/mob/living/proc/death_message()
	src.visible_message("<b>\The [src.name]</b> seizes up and falls limp, their eyes dead and lifeless...")
	return TRUE

/mob/living/proc/death()

	if(dead)
		return FALSE

	if(boss)
		SSbosses.living_bosses -= src

	death_message()

	pre_death()

	src.to_chat(span("danger","<h1>You died!</h1>"))
	src.to_chat(span("danger","Your death is not the end. Someone may come along and revive you, or you can be cloned again by ghosting and loading your current character."))
	src.to_chat(span("danger","Be warned, if you choose to be cloned or you cannot be revived, you will lose all your items until they are retrieved again!."))

	dead = TRUE
	time_of_death = world.time

	if(stand && stand.linked_stand)
		stand.linked_stand.set_enabled(FALSE)
		remove_stand()

	if(ai)
		ai.on_death()

	var/turf/T = get_turf(src)

	if(boss && boss_loot)
		var/obj/structure/interactive/boss_loot/BL = new(T)
		BL.loot_to_give = boss_loot
		BL.allowed_users = players_fighting_boss.Copy()
		INITIALIZE(BL)
		GENERATE(BL)
		FINALIZE(BL)

	create_alert(VIEW_RANGE*0.5,T, alert_level = ALERT_LEVEL_CAUTION, visual = TRUE)

	movement_flags = 0x0
	attack_flags = 0x0

	plane = PLANE_OBJ
	layer = 1000

	handle_horizontal()

	if(following)
		following.followers -= src
		following = null

	if(is_sneaking)
		is_sneaking = FALSE
		handle_alpha()

	post_death()

	if(queue_delete_on_death)
		queue_delete(src,ITEM_DELETION_TIME_DROPPED,TRUE)

	var/obj/hud/button/dead_ghost/DG = new
	DG.update_owner(src)

	if(client)
		notify_ghosts("[src.name] has died!",T)

	if(master)
		dust()

	return TRUE

/*
/mob/living/proc/do_loot_drop(var/atom/desired_loc)

	if(desired_loc && loot_drop && health)
		var/loot/L = all_loot[loot_drop]

		if(!isturf(desired_loc))
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
	movement_flags = 0x0
	attack_flags = 0x0
	dead = FALSE
	remove_status_effect(CRIT)
	plane = initial(plane)
	layer = initial(layer)
	if(ai)
		ai.set_active(TRUE)
	for(var/obj/hud/button/dead_ghost/DG in buttons)
		DG.update_owner(null)
	if(health)
		health.update_health(update_hud=TRUE,check_death=TRUE)
	handle_horizontal()
	undelete(src)
	return TRUE

/mob/living/proc/rejuvenate()
	if(health) health.adjust_loss_smart(
		brute = -health.get_loss(BRUTE),
		burn = -health.get_loss(BURN),
		tox = -health.get_loss(TOX),
		oxy = -health.get_loss(OXY),
		fatigue = -health.get_loss(FATIGUE),
		pain = -health.get_loss(PAIN),
		rad = -health.get_loss(RAD),
		sanity = -health.get_loss(SANITY),
		mental = -health.get_loss(MENTAL)
	)
	blood_volume = blood_volume_max
	if(reagents) reagents.remove_all_reagents()
	return TRUE

/mob/living/proc/resurrect()
	rejuvenate()
	revive()
	return TRUE

/mob/living/proc/pre_death()
	alert_overlay.icon_state = "none"
	chat_overlay.icon_state = "none"
	return TRUE

/mob/living/proc/post_death()
	HOOK_CALL("post_death")
	return TRUE

/mob/living/can_attack(var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(dead)
		return FALSE

	if(has_status_effects(PARALYZE,SLEEP,STAGGER,STAMCRIT,STUN))
		return FALSE

	if(grabbing_hand && grabbing_hand.owner && get_dir(grabbing_hand.owner,src) == src.dir)
		return FALSE

	return ..()

/*
/mob/living/can_use_controls(object,location,control,params)

	/*
	if(dead)
		return FALSE

	if(has_status_effects(PARALYZE,SLEEP,STAGGER,STUN))
		return FALSE
	*/

	return ..()
*/

/mob/living/proc/handle_horizontal()

	var/desired_horizontal = dead || has_status_effects(STUN,STAMCRIT,SLEEP,CRIT,REST,PAINCRIT)

	if(desired_horizontal != horizontal)
		if(desired_horizontal) //KNOCK DOWN
			if(stun_angle != 0) animate(src,transform = turn(matrix(), stun_angle), pixel_z = 0, time = 1)
			update_collisions(FLAG_COLLISION_CRAWLING)
			play_sound(pick('sound/effects/impacts/bodyfall2.ogg','sound/effects/impacts/bodyfall3.ogg','sound/effects/impacts/bodyfall4.ogg'),get_turf(src), volume = 25,range_max=VIEW_RANGE*0.5)
		else //GET UP
			if(stun_angle != 0) animate(src,transform = matrix(), pixel_z = initial(src.pixel_z), time = 2)
			update_collisions(initial(collision_flags))
		horizontal = desired_horizontal

	return desired_horizontal

/mob/living/proc/on_life()

	if(!initialized || qdeleting)
		return FALSE

	handle_status_effects()

	handle_blocking()

	handle_health_buffer()

	update_alpha(handle_alpha())

	if(health && queue_health_update)
		health.update_health()
		queue_health_update = FALSE

	return TRUE

/*
/mob/living/proc/handle_charges(var/charge_gain = 0)

	var/dodge_power = src.get_skill_power(SKILL_DODGE)
	var/block_power = src.get_skill_power(SKILL_BLOCK)
	var/parry_power = src.get_skill_power(SKILL_PARRY)

	var/old_dodge = charge_dodge
	var/old_block = charge_block
	var/old_parry = charge_parry

	charge_dodge = min(charge_dodge + charge_gain*dodge_power,CEILING(dodge_power*500,100))
	charge_block = min(charge_block + charge_gain*block_power,CEILING(block_power*500,100))
	charge_parry = min(charge_parry + charge_gain*parry_power,CEILING(parry_power*500,100))

	if(!charge_gain || old_dodge != charge_dodge || old_block != charge_block || !old_parry != charge_parry)
		for(var/obj/hud/button/evade/B in buttons)
			B.update_overlays()
		return TRUE

	return FALSE
*/

/mob/living/proc/handle_hunger()

	var/thirst_mod = health && (health.stamina_current <= health.stamina_max*0.5) ? 2 : 1
	var/quality_mod = 1 + clamp(1 - get_nutrition_quality_mod(),0,1)*5

	add_nutrition(-(LIFE_TICK_SLOW/10)*0.10*quality_mod)
	add_nutrition_fast(-(LIFE_TICK_SLOW/10)*0.20*quality_mod)
	add_hydration(-(LIFE_TICK_SLOW/10)*0.05*thirst_mod)

	if(client)
		for(var/obj/hud/button/hunger/B in buttons)
			B.update_sprite()

	return TRUE


mob/living/proc/on_life_slow()

	if(!initialized)
		return FALSE

	if(minion_remove_time && minion_remove_time <= world.time)
		dust()
		return TRUE

	if(talk_duration)
		talk_duration = max(0,talk_duration-LIFE_TICK_SLOW)
		if(talk_duration <= 0 && !is_typing)
			animate(chat_overlay,alpha = 0,time=SECONDS_TO_DECISECONDS(1))

	handle_fire()

	if(dead)
		return FALSE

	if(ai && !ai.active)
		return FALSE

	if(blood_volume < blood_volume_max)
		var/blood_volume_to_add = -(add_hydration(-0.05) + add_nutrition(-0.3))*0.5
		blood_volume = clamp(blood_volume + blood_volume_to_add,0,blood_volume_max)
		queue_health_update = TRUE
	else if(blood_volume > blood_volume_max)
		blood_volume--
		if(health && blood_volume >= blood_volume_max*1.05)
			health.adjust_loss_smart(tox=0.5,robotic=FALSE)

	handle_regen()

	if(reagents)
		reagents.metabolize()

	//handle_charges(LIFE_TICK_SLOW)

	handle_hunger()

	handle_intoxication()

	return TRUE

/mob/living/proc/handle_intoxication()

	if(intoxication)
		var/intoxication_to_remove = (0.025 + intoxication*0.0025)*(LIFE_TICK_SLOW/10)
		intoxication = max(0,intoxication-intoxication_to_remove)

	switch(intoxication)
		if(0 to 200)
			if(last_intoxication_message != 0)
				to_chat(span("notice","You feel sober."))
				last_intoxication_message = 0
		if(200 to 400)
			if(last_intoxication_message != 1)
				to_chat(span("notice","You feel buzzed."))
				last_intoxication_message = 1
		if(400 to 800)
			if(last_intoxication_message != 2)
				to_chat(span("warning","You feel drunk."))
				last_intoxication_message = 2
		if(800 to 1600)
			if(last_intoxication_message != 3)
				to_chat(span("danger","You feel seriously inebriated."))
				last_intoxication_message = 3
		if(1600 to INFINITY)
			if(last_intoxication_message != 4)
				to_chat(span("danger","You feel utterly and completely fucking shitfaced."))
				last_intoxication_message = 4
			health.adjust_loss_smart(tox=0.25*(LIFE_TICK_SLOW/10),robotic = FALSE)
			queue_health_update = TRUE

	if(intoxication >= 600 && prob(intoxication/100))
		var/list/possible_status_effects = list(
			STAGGER,
			CONFUSED,
			SLIP
		)
		add_status_effect(pick(possible_status_effects),40,40)


	return TRUE

/mob/living/proc/handle_alpha()

	var/base_alpha = initial(alpha)

	if(is_sneaking)
		var/desired_alpha = FLOOR(10 + (1-stealth_mod)*base_alpha*0.5, 1)
		if(horizontal)
			desired_alpha *= 0.5
		return desired_alpha

	return base_alpha


/mob/living/proc/can_buffer_health()
	return (brute_regen_buffer || burn_regen_buffer || tox_regen_buffer || pain_regen_buffer || rad_regen_buffer || sanity_regen_buffer)

/mob/living/proc/can_buffer_stamina()
	return stamina_regen_buffer

/mob/living/proc/can_buffer_mana()
	return mana_regen_buffer

/mob/living/proc/handle_health_buffer()

	if(!health)
		return FALSE

	var/update_health = FALSE
	var/update_stamina = FALSE
	var/update_mana = FALSE

	if(can_buffer_health())
		var/brute_to_regen = clamp(brute_regen_buffer,HEALTH_REGEN_BUFFER_MIN,HEALTH_REGEN_BUFFER_MAX)
		var/burn_to_regen = clamp(burn_regen_buffer,HEALTH_REGEN_BUFFER_MIN,HEALTH_REGEN_BUFFER_MAX)
		var/tox_to_regen = clamp(tox_regen_buffer,HEALTH_REGEN_BUFFER_MIN,HEALTH_REGEN_BUFFER_MAX)
		var/pain_to_regen = clamp(pain_regen_buffer,HEALTH_REGEN_BUFFER_MIN,HEALTH_REGEN_BUFFER_MAX)
		var/rad_to_regen = clamp(rad_regen_buffer,HEALTH_REGEN_BUFFER_MIN,HEALTH_REGEN_BUFFER_MAX)
		var/sanity_to_regen = clamp(sanity_regen_buffer,HEALTH_REGEN_BUFFER_MIN,HEALTH_REGEN_BUFFER_MAX)
		health.adjust_loss_smart(
			brute = -brute_to_regen,
			burn = -burn_to_regen,
			tox=-tox_to_regen,
			pain=-pain_to_regen,
			rad=-rad_to_regen,
			sanity=-sanity_to_regen,
			robotic=FALSE
		)
		brute_regen_buffer -= brute_to_regen
		burn_regen_buffer -= burn_to_regen
		tox_regen_buffer -= tox_to_regen
		pain_regen_buffer -= pain_to_regen
		rad_regen_buffer -= rad_to_regen
		sanity_regen_buffer -= sanity_to_regen
		update_health = TRUE

	if(can_buffer_stamina())
		var/stamina_to_regen = clamp(stamina_regen_buffer,STAMINA_REGEN_BUFFER_MIN,STAMINA_REGEN_BUFFER_MAX)
		health.adjust_stamina(stamina_to_regen)
		stamina_regen_buffer -= stamina_to_regen
		update_stamina = TRUE

	if(can_buffer_mana())
		var/mana_to_regen = clamp(mana_regen_buffer,MANA_REGEN_BUFFER_MIN,MANA_REGEN_BUFFER_MAX)
		health.adjust_mana(mana_to_regen)
		mana_regen_buffer -= mana_to_regen
		update_mana = TRUE

	if(update_health || update_stamina || update_mana)
		queue_health_update = TRUE
		return TRUE

	return FALSE

/mob/living/proc/handle_regen()

	if(!health)
		return FALSE

	if(health.health_regeneration <= 0 && health.stamina_regeneration <= 0 && health.mana_regeneration <= 0)
		return FALSE

	var/delay_mod = LIFE_TICK_SLOW

	var/health_adjust = 0
	var/mana_adjust = 0
	var/stamina_adjust = 0

	health_regen_delay = max(0,health_regen_delay - delay_mod)
	stamina_regen_delay = max(0,stamina_regen_delay - delay_mod)
	mana_regen_delay = max(0,mana_regen_delay - delay_mod)

	var/nutrition_hydration_mod = get_nutrition_mod() * get_hydration_mod()
	var/player_controlled = is_player_controlled()

	if(health_regen_delay <= 0 && health.health_regeneration > 0)
		var/health_mod = DECISECONDS_TO_SECONDS(health.health_regeneration * delay_mod * nutrition_hydration_mod)
		var/brute_to_adjust = min(max(0,health.get_loss(BRUTE) - brute_regen_buffer),health_mod)
		var/burn_to_adjust = min(max(0,health.get_loss(BURN) - burn_regen_buffer),health_mod)
		var/pain_to_adjust = min(max(0,health.get_loss(PAIN) - pain_regen_buffer),health_mod)
		health_adjust += brute_to_adjust + burn_to_adjust + pain_to_adjust
		if(health_adjust)
			brute_regen_buffer += brute_to_adjust
			burn_regen_buffer += burn_to_adjust
			pain_regen_buffer += pain_to_adjust
			if(health_adjust > 0 && player_controlled)
				add_attribute_xp(ATTRIBUTE_FORTITUDE,health_adjust*10)

	if(stamina_regen_delay <= 0 && health.stamina_regeneration > 0)
		stamina_adjust += min(max(0,health.get_stamina_loss() - stamina_regen_buffer),health.stamina_regeneration*delay_mod*nutrition_hydration_mod*0.1)
		if(stamina_adjust)
			stamina_regen_buffer += stamina_adjust
			if(stamina_adjust > 0 && player_controlled)
				add_attribute_xp(ATTRIBUTE_RESILIENCE,stamina_adjust*10)

	if(mana_regen_delay <= 0 && health.mana_regeneration > 0)
		mana_adjust = min(max(0,health.get_mana_loss() - mana_regen_buffer),health.mana_regeneration*delay_mod*nutrition_hydration_mod*0.1*(1 + (health.mana_current/health.mana_max)*3)) //The 0.1 converts from seconds to deciseconds.
		if(mana_adjust)
			mana_regen_buffer += mana_adjust
			if(mana_adjust > 0 && player_controlled)
				add_attribute_xp(ATTRIBUTE_WILLPOWER,mana_adjust*10)

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
