/mob/living/proc/death_message()
	src.visible_message("<b>\The [src.name]</b> seizes up and falls limp, their eyes dead and lifeless...")
	return TRUE

/mob/living/proc/death(var/silent=FALSE)

	if(dead)
		return FALSE

	is_moving = FALSE

	if(boss)
		SSbosses.living_bosses -= src

	if(!silent) death_message()

	pre_death()

	dead = TRUE
	time_of_death = world.time

	if(stand && stand.linked_stand)
		stand.linked_stand.set_enabled(FALSE)
		remove_stand()

	if(ai) ai.on_death()

	var/turf/T = get_turf(src)

	if(T)
		if(boss && boss_loot)
			var/obj/structure/interactive/boss_loot/BL = new(T)
			BL.loot_to_give = boss_loot
			BL.allowed_users = players_fighting_boss.Copy()
			INITIALIZE(BL)
			GENERATE(BL)
			FINALIZE(BL)

		if(!silent) create_alert(VIEW_RANGE*0.5,T, alert_level = ALERT_LEVEL_CAUTION, visual = TRUE)

		if(boss && !drops_gold)
			drops_gold = RAND_PRECISE(0.5,1.25) * level * (1/SSeconomy.credits_per_gold) * 10

		if(drops_gold > 0)
			create_gold_drop(T,CEILING(drops_gold,1))
			drops_gold = 0


	movement_flags = 0x0
	attack_flags = 0x0

	if(following)
		following.followers -= src
		following = null

	if(is_sneaking)
		is_sneaking = FALSE
		handle_alpha()

	post_death()

	if(ckey_last)
		var/obj/hud/button/dead_ghost/DG = new
		DG.update_owner(src)

	if(master)
		dust()
	else if(soul_size && has_status_effect(SOULTRAP) && !is_player_controlled())
		var/obj/effect/temp/soul/S = new(T,SECONDS_TO_DECISECONDS(20))
		S.appearance = src.appearance
		S.transform = get_base_transform()
		S.color = "#000000"
		S.plane = PLANE_EFFECT
		S.layer = LAYER_GHOST
		S.name = "soul of [initial(name)]:"
		S.soul_size = src.soul_size
		INITIALIZE(S)
		GENERATE(S)
		FINALIZE(S)
		remove_status_effect(SOULTRAP)

	update_eyes()

	handle_transform()

	if(!silent && !qdeleting && client)
		client.to_chat(span("danger","<h1>You died!</h1>"))
		client.to_chat(span("danger","Your death is not the end. Someone may come along and revive you, or you can be cloned again by ghosting and loading your current character."))
		client.to_chat(span("danger","Be warned, if you choose to be cloned or you suffer from brain death, you will need to retrieve your items!."))

	return TRUE


/*
/mob/living/proc/do_loot_drop(var/atom/desired_loc)

	if(desired_loc && loot_drop && health)
		var/loot/L = all_loot[loot_drop]

		if(!is_turf(desired_loc))
			return FALSE

		if(loot_drop_in_corpse)
			L.spawn_loot_corpse(desired_loc)
		else
			L.spawn_loot_turf(desired_loc)

		var/obj/item/currency/C = new(src.loc)
		C.value = 1 + FLOOR(health.health_max/10, 1)
		INITIALIZE(C)
		step_rand(C)
		return TRUE

	return FALSE
*/

/mob/living/proc/revive()
	if(!dead)
		return FALSE
	CALLBACK_REMOVE("\ref[src]_make_unrevivable")
	hit_logs = list() //Clear logs.
	movement_flags = 0x0
	attack_flags = 0x0
	dead = FALSE
	remove_status_effect(CRIT)
	if(ai)
		var/turf/T = get_turf(src)
		if(T)
			var/chunk/C = CHUNK(T)
			if(C && C.visited_by_player)
				ai.set_active(TRUE)
	for(var/obj/hud/button/dead_ghost/DG in buttons)
		DG.update_owner(null)
	handle_transform()
	update_eyes()
	return TRUE

/mob/living/proc/rejuvenate()
	blood_volume = blood_volume_max
	if(reagents) reagents.remove_all_reagents()
	nutrition = max(nutrition,initial(nutrition))
	nutrition_fast = max(nutrition_fast,initial(nutrition_fast))
	hydration = max(hydration,initial(hydration))
	nutrition_quality = max(nutrition_quality,initial(nutrition_quality))
	intoxication = initial(intoxication)
	on_fire = initial(on_fire)
	fire_stacks = initial(fire_stacks)
	if(health)
		health.restore()
	remove_all_status_effects()
	brute_regen_buffer = 0
	burn_regen_buffer = 0
	tox_regen_buffer = 0
	pain_regen_buffer = 0
	rad_regen_buffer = 0
	sanity_regen_buffer = 0
	mental_regen_buffer = 0
	mana_regen_buffer = 0
	stamina_regen_buffer = 0
	return TRUE

/mob/living/proc/resurrect()
	return rejuvenate() && revive()

/mob/living/proc/pre_death()
	brute_regen_buffer = max(brute_regen_buffer,0)
	burn_regen_buffer = max(burn_regen_buffer,0)
	tox_regen_buffer = max(tox_regen_buffer,0)
	pain_regen_buffer = max(pain_regen_buffer,0)
	rad_regen_buffer = max(rad_regen_buffer,0)
	sanity_regen_buffer = max(sanity_regen_buffer,0)
	mental_regen_buffer = max(mental_regen_buffer,0)
	mana_regen_buffer = max(mana_regen_buffer,0)
	stamina_regen_buffer = max(stamina_regen_buffer,0)
	if(alert_overlay) alert_overlay.icon_state = "none"
	if(chat_overlay) chat_overlay.icon_state = "none"
	HOOK_CALL("pre_death")
	return TRUE

/mob/living/proc/post_death()

	var/turf/T = get_turf(src)

	//Was it a kill?
	if(!suicide)
		var/list/people_who_contributed = list()
		var/list/people_who_killed = list()
		for(var/k in hit_logs)
			var/list/attack_log = k
			if(attack_log["lethal"])
				people_who_killed[attack_log["attacker"]] += 1
			else if(attack_log["critical"])
				people_who_contributed[attack_log["attacker"]] += 1
		if(!length(people_who_killed))
			//Fallback.
			people_who_killed = people_who_contributed

		on_killed(people_who_killed) //people_who_killed can be empty.

		if(length(people_who_killed))
			if(!boss)
				if(!was_killed && !master && soul_size && !delete_on_death && health && health.health_max >= 100)
					for(var/k in people_who_killed)
						var/mob/living/advanced/player/P = k
						if(!is_player(P) || !P.job)
							continue
						if(P.loyalty_tag == src.loyalty_tag)
							continue
						var/job/J = JOB(P.job)
						if(!J || !(J.job_flags & FLAG_JOB_KILLING))
							continue
						var/income_multiplier = J.active_income_multiplier + J.active_income_multiplier_bonus*P.job_rank
						if(income_multiplier >= 0)
							var/credits_to_give = min(CEILING(health.health_max*0.1,5),300)*income_multiplier
							var/credits_given = P.adjust_currency(credits_to_give,silent=TRUE)
							if(credits_given > 0)
								P.to_chat(span("notice","You gained [credits_given] credits for killing [src.name]."),CHAT_TYPE_COMBAT)
			else
				var/rarity = 0
				var/rarity_count = 0
				var/list/valid_ckeys = list()
				for(var/k in people_who_killed)
					var/mob/living/advanced/player/P = k
					if(!is_player(P))
						continue
					rarity += P.get_rarity()
					rarity_count++
					if(P.ckey_last)
						valid_ckeys += P.ckey_last
					INCREASE_ACHIEVEMENT(P,"bosses_killed",1)
				if(T)
					if(length(valid_ckeys))
						create_gold_drop(T,CEILING(src.health.health_max/10,1),valid_ckeys)
					if(rarity_count > 0)
						rarity *= 1/rarity_count
						var/list/loot_spawned = SPAWN_LOOT(/loot/boss,T,rarity)
						for(var/k in loot_spawned)
							var/obj/item/I = k
							var/item_move_dir = pick(DIRECTIONS_ALL)
							var/turf/turf_to_move_to = get_step(T,item_move_dir)
							if(!turf_to_move_to)
								turf_to_move_to = T
							I.force_move(turf_to_move_to)
							var/list/pixel_offsets = direction_to_pixel_offset(item_move_dir)
							I.pixel_x = -pixel_offsets[1]*TILE_SIZE
							I.pixel_y = -pixel_offsets[2]*TILE_SIZE
							animate(I,pixel_x=rand(-8,8),pixel_y=rand(-8,8),time=5)


	HOOK_CALL("post_death")

	if(expiration_time == -1)
		make_unrevivable()
	else if(expiration_time > 0)
		CALLBACK("\ref[src]_make_unrevivable",expiration_time,src,src::make_unrevivable())

	if(delete_on_death)
		qdel(src)

	was_killed = TRUE

	return TRUE

/mob/living/proc/on_kill(var/mob/living/victim)
	HOOK_CALL("on_kill")
	return TRUE

/mob/living/proc/on_killed(var/list/attackers)
	for(var/k in attackers)
		var/mob/living/L = k
		L.on_kill(src)
	HOOK_CALL("on_killed")
	return TRUE

/mob/living/proc/on_life()

	if(!dead)
		handle_natural_regen()

	handle_health_buffer()

	if(flash_overlay && flash_overlay.duration > 0)
		flash_overlay.duration -= TICKS_TO_DECISECONDS(LIFE_TICK)
		if(flash_overlay.duration <= 0)
			animate(flash_overlay,alpha=0,time=SECONDS_TO_DECISECONDS(5))

	if(deafened_duration && deafened_duration > 0)
		deafened_duration -= TICKS_TO_DECISECONDS(LIFE_TICK)

	//Fire stacks.
	if(fire_stacks)
		adjust_fire_stacks(-min(fire_stacks,TICKS_TO_DECISECONDS(LIFE_TICK)))
		if(on_fire && health)
			var/damagetype/DT = all_damage_types[/damagetype/on_fire]
			var/damage_multiplier = 3 + (fire_stacks/MAX_FIRE_STACKS)*(TICKS_TO_DECISECONDS(LIFE_TICK/8))*5
			for(var/i=1,i<=3,i++)
				var/list/params = list()
				params[PARAM_ICON_X] = rand(0,32)
				params[PARAM_ICON_Y] = rand(0,32)
				var/atom/object_to_damage = src.get_object_to_damage(src,src,/damagetype/on_fire,params,TRUE,TRUE)
				DT.process_damage(src,src,src,object_to_damage,src,damage_multiplier)

	return TRUE

/mob/living/proc/on_life_fast()

	for(var/k in stat_elements_to_update)
		var/obj/hud/button/stat/B = k
		if(!B || !B.update())
			stat_elements_to_update -= k

	if(stun_immunity > 0)
		stun_immunity = max(stun_immunity - TICKS_TO_DECISECONDS(LIFE_TICK_FAST),0)
	else if(stun_immunity < 0)
		stun_immunity = min(stun_immunity + TICKS_TO_DECISECONDS(LIFE_TICK_FAST),0)

	if(length(status_effects))
		handle_status_effects(TICKS_TO_DECISECONDS(LIFE_TICK_FAST))

	/* TODO: Make this less shit.
	if(client && !dead && health && next_heartbeat <= world.time)
		var/desired_heartrate = 60
		if(has_status_effect(ADRENALINE))
			desired_heartrate += 40
		if(health.health_current - health.damage[PAIN] <= 0)
			desired_heartrate += ((health.health_current - health.damage[PAIN])/health.health_max)*60 //This will be negative
		if(health.stamina_current < health.stamina_max)
			desired_heartrate += (1 - health.stamina_current/health.stamina_max)*60

		desired_heartrate -= min(pain_removal,40)

		if(abs(desired_heartrate - 60) > 30)
			var/turf/T = get_turf(src)
			play_sound('sound/effects/heartbeat_single.ogg',T,list(src),pitch=0.5 + (60/desired_heartrate)*0.5,volume=10)
		next_heartbeat = world.time + 1/max(0.025,desired_heartrate/600)
	*/

	return TRUE

mob/living/proc/on_life_slow()

	if(minion_remove_time && minion_remove_time <= world.time)
		dust()
		return TRUE

	//Immune system
	immune_system_strength = initial(immune_system_strength)
	for(var/k in diseases)
		var/disease/D = diseases[k]
		D.on_life(src)
		if(D.stage >= D.immune_system_mod_starts_at_stage)
			immune_system_strength += D.stage*D.immune_system_mod

	if(immune_system_strength > 0)
		immune_system_strength *= get_nutrition_quality_mod()
		if(blood_type && blood_volume_max > 0)
			immune_system_strength *= min(1,blood_volume/blood_volume_max)
		immune_system_strength *= chem_power
		if(health && health.health_max > 0) immune_system_strength *= health.health_current/health.health_max
	immune_system_strength = max(0,FLOOR(immune_system_strength,1))

	//Talking.
	if(talk_duration)
		talk_duration = max(0,talk_duration-TICKS_TO_DECISECONDS(LIFE_TICK_SLOW))
		if(talk_duration <= 0 && !is_typing)
			animate(chat_overlay,alpha = 0,time=SECONDS_TO_DECISECONDS(1))

	if(dead)
		return FALSE

	blood_toxicity = max(blood_toxicity - TICKS_TO_DECISECONDS(LIFE_TICK_SLOW)*0.1,0)
	if(blood_toxicity > 20)
		chem_power = max(0,1 - (blood_toxicity-20)*0.01)
	else
		chem_power = 1

	if(blood_type && blood_volume_max > 0)
		if(blood_volume < blood_volume_max)
			var/blood_volume_to_add = -(add_hydration(-0.15) + add_nutrition(-1.2))*0.125
			blood_volume = clamp(blood_volume + blood_volume_to_add,0,blood_volume_max)
			QUEUE_HEALTH_UPDATE(src)
		else if(blood_volume > blood_volume_max)
			blood_volume -= TICKS_TO_DECISECONDS(LIFE_TICK_SLOW)*0.25
			if(blood_volume >= blood_volume_max*1.1)
				tox_regen_buffer -= TICKS_TO_DECISECONDS(LIFE_TICK_SLOW)*0.25*0.25

	if(reagents)
		reagents.metabolize(src,TICKS_TO_SECONDS(LIFE_TICK_SLOW))

	handle_hunger()

	handle_intoxication()

	return TRUE

/mob/living/proc/handle_hunger()

	var/hunger_mod = 1 + clamp(1 - get_nutrition_quality_mod(),0,1)*3
	var/thirst_mod = 1 //Should this be based on something?

	if(hunger_mod > 0)
		add_nutrition(-0.04*hunger_mod*TICKS_TO_SECONDS(LIFE_TICK_SLOW))
		add_nutrition_fast(-0.08*hunger_mod*TICKS_TO_SECONDS(LIFE_TICK_SLOW))
		add_hydration(-0.13*thirst_mod*TICKS_TO_SECONDS(LIFE_TICK_SLOW))

	if(client) //TODO: FIX THIS SHITCODE.
		for(var/obj/hud/button/hunger/B in buttons)
			B.update_icon()
		for(var/obj/hud/button/thirst/B in buttons)
			B.update_icon()

/mob/living/proc/handle_intoxication()

	if(!intoxication)
		return TRUE

	var/threshold_multiplier = 1
	var/intoxication_to_remove = (0.025 + intoxication*0.0025)*TICKS_TO_DECISECONDS(LIFE_TICK_SLOW)

	intoxication = max(0,intoxication-intoxication_to_remove)

	switch(intoxication/threshold_multiplier)
		if(0 to 200)
			if(last_intoxication_message != 0)
				to_chat(span("notice","You feel sober."))
				intoxication_to_remove *= 0.5
				last_intoxication_message = 0
		if(200 to 400)
			if(last_intoxication_message != 1)
				to_chat(span("notice","You feel buzzed."))
				intoxication_to_remove *= 0.5
				last_intoxication_message = 1
		if(400 to 800)
			if(last_intoxication_message != 2)
				to_chat(span("warning","You feel drunk."))
				intoxication_to_remove *= 0.75
				last_intoxication_message = 2
		if(800 to 1600)
			if(last_intoxication_message != 3)
				to_chat(span("danger","You feel seriously inebriated."))
				intoxication_to_remove *= 0.5
				last_intoxication_message = 3
		if(1600 to INFINITY)
			if(last_intoxication_message != 4)
				to_chat(span("danger","You feel utterly and completely fucking shitfaced."))
				intoxication_to_remove *= 0.25
				last_intoxication_message = 4
			tox_regen_buffer -= 0.25*TICKS_TO_SECONDS(LIFE_TICK_SLOW)

	if((intoxication/threshold_multiplier) >= 600 && prob((intoxication/threshold_multiplier)/100))
		var/list/possible_status_effects = list(
			STAGGER,
			CONFUSED,
			SLIP
		)
		add_status_effect(pick(possible_status_effects),40,40)


	return TRUE

/mob/living/proc/handle_alpha()
	return initial(alpha)

/mob/living/proc/can_buffer_health()
	return (brute_regen_buffer || burn_regen_buffer || tox_regen_buffer || pain_regen_buffer || rad_regen_buffer || sanity_regen_buffer || mental_regen_buffer)

/mob/living/proc/can_buffer_stamina()
	return stamina_regen_buffer

/mob/living/proc/can_buffer_mana()
	return mana_regen_buffer

/mob/living/proc/handle_health_buffer()

	if(!health)
		return FALSE

	var/multiplier = TICKS_TO_SECONDS(LIFE_TICK)

	if(can_buffer_health())
		var/brute_to_regen = clamp(
			brute_regen_buffer,
			-health.health_max*0.05,
			health.health_max*0.05
		)*multiplier
		var/burn_to_regen = clamp(
			burn_regen_buffer,
			-health.health_max*0.05,
			health.health_max*0.05
		)*multiplier
		var/tox_to_regen = clamp(
			tox_regen_buffer,
			-health.health_max*0.05,
			health.health_max*0.05
		)*multiplier
		//Pain is different.
		var/pain_to_regen = 0
		if(pain_regen_buffer > 0)
			pain_to_regen = min(
				pain_regen_buffer,
				0.025 + pain_regen_buffer*0.025*multiplier,
				health.health_max*0.05*multiplier
			) //Get the smallest out of these 4.
		else
			pain_to_regen = max(
				pain_regen_buffer,
				-health.health_max*0.01*multiplier,
				-100/300 //Takes 5 minutes to process 100 pain.
			)
		var/rad_to_regen = clamp(
			rad_regen_buffer,
			-health.health_max*0.05,
			health.health_max*0.05
		)*multiplier
		var/sanity_to_regen = clamp(
			sanity_regen_buffer,
			-health.health_max*0.05,
			health.health_max*0.05
		)*multiplier
		var/mental_to_regen = clamp(
			mental_regen_buffer,
			-health.health_max*0.05,
			health.health_max*0.05
		)*multiplier
		src.health.adjust_loss_smart(
			brute = -brute_to_regen,
			burn = -burn_to_regen,
			tox = -tox_to_regen,
			pain = -pain_to_regen,
			rad = -rad_to_regen,
			sanity = -sanity_to_regen,
			mental = -mental_to_regen,
			robotic = FALSE
		)
		brute_regen_buffer -= brute_to_regen
		burn_regen_buffer -= burn_to_regen
		tox_regen_buffer -= tox_to_regen
		pain_regen_buffer -= pain_to_regen
		rad_regen_buffer -= rad_to_regen
		sanity_regen_buffer -= sanity_to_regen

	if(can_buffer_stamina())
		var/stamina_to_regen = clamp(
			stamina_regen_buffer,
			-health.stamina_max*0.05,
			health.stamina_max*0.05
		)*multiplier
		health.adjust_stamina(stamina_to_regen)
		stamina_regen_buffer -= stamina_to_regen

	if(can_buffer_mana())
		var/mana_to_regen = clamp(
			mana_regen_buffer,
			-health.mana_max*0.05,
			health.mana_max*0.05
		)*multiplier
		health.adjust_mana(mana_to_regen)
		mana_regen_buffer -= mana_to_regen

	return FALSE

/mob/living/proc/handle_natural_regen()

	if(!health)
		return FALSE

	if(health.health_regeneration <= 0 && health.stamina_regeneration <= 0 && health.mana_regeneration <= 0)
		return FALSE

	if(health.health_regen_cooef <= 0 && health.stamina_regen_cooef <= 0 && health.mana_regen_cooef <= 0)
		return FALSE

	var/delay_mod = TICKS_TO_DECISECONDS(LIFE_TICK)

	health_regen_delay = max(0,health_regen_delay - delay_mod)
	stamina_regen_delay = max(0,stamina_regen_delay - delay_mod)
	mana_regen_delay = max(0,mana_regen_delay - delay_mod)

	var/nutrition_hydration_mod = 1 + get_nutrition_quality_mod()
	var/player_controlled = is_player_controlled()

	if(health.health_regen_cooef > 0 && health_regen_delay <= 0 && health.health_regeneration > 0)
		var/health_mod = DECISECONDS_TO_SECONDS(delay_mod) * health.health_regeneration * nutrition_hydration_mod
		var/brute_to_adjust = clamp(health.damage[BRUTE]*health.health_regen_cooef - brute_regen_buffer,0,health_mod)
		var/burn_to_adjust = clamp(health.damage[BURN]*health.health_regen_cooef - burn_regen_buffer,0,health_mod)
		var/pain_to_adjust = clamp(health.damage[PAIN]*health.health_regen_cooef - pain_regen_buffer,0,health_mod)
		if(brute_to_adjust != 0 || burn_to_adjust != 0 || pain_to_adjust != 0)
			brute_regen_buffer += brute_to_adjust
			burn_regen_buffer += burn_to_adjust
			pain_regen_buffer += pain_to_adjust
			var/total_adjust = max(0,brute_to_adjust) + max(0,burn_regen_buffer) + max(0,pain_regen_buffer)
			if(total_adjust > 0 && player_controlled)
				add_attribute_xp(ATTRIBUTE_FORTITUDE,total_adjust)

	if(health.stamina_regen_cooef > 0 && stamina_regen_delay <= 0 && health.stamina_regeneration > 0)
		var/stamina_to_regen = DECISECONDS_TO_SECONDS(delay_mod)*health.stamina_regeneration*nutrition_hydration_mod
		var/stamina_adjust = min(max(0,(health.stamina_max - health.stamina_current)*health.stamina_regen_cooef - stamina_regen_buffer),stamina_to_regen)
		if(stamina_adjust != 0)
			stamina_regen_buffer += stamina_adjust
			if(stamina_adjust > 0 && player_controlled)
				add_attribute_xp(ATTRIBUTE_RESILIENCE,stamina_adjust)

	if(health.mana_regen_cooef > 0 && mana_regen_delay <= 0 && health.mana_regeneration > 0)
		var/mana_to_regen = DECISECONDS_TO_SECONDS(delay_mod)*health.mana_regeneration*nutrition_hydration_mod*(1+(health.mana_current/health.mana_max)*3)
		var/mana_adjust = min(max(0,(health.mana_max - health.mana_current)*health.mana_regen_cooef - mana_regen_buffer),mana_to_regen)
		if(mana_adjust != 0)
			mana_regen_buffer += mana_adjust
			if(mana_adjust > 0 && player_controlled)
				add_attribute_xp(ATTRIBUTE_WILLPOWER,mana_adjust)

	return TRUE


/mob/living/proc/smite()
	var/turf/T = get_turf(src)
	for(var/mob/M in range(T,8))
		if(!M.client)
			continue
		M.client.queued_shakes += 5
	new/obj/effect/temp/fist(T,4,"#FFFFFF")
	play_sound('sound/effects/anima_fragment_attack.ogg',T,range_max=VIEW_RANGE)
	on_crush()
	return TRUE


/mob/living/proc/make_unrevivable() //only applies to players.

	if(client)
		var/client/C = client
		var/turf/T = get_turf(src)
		C.make_ghost(T ? T : locate(FLOOR(world.maxx/2,1),FLOOR(world.maxy/2,1),1))
		C.to_chat(span("danger","You have suffered brain death and can no longer be revived..."))
	else
		ckey_last = null

	CALLBACK_REMOVE("\ref[src]_make_unrevivable")

	return TRUE