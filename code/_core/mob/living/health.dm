/mob/living/proc/add_health_element(var/obj/hud/button/health/H)
	health_elements[H.id] = H
	if(client)
		client.screen += H
	update_health_elements()

/mob/living/proc/remove_health_element(var/obj/hud/button/health/H)
	health_elements -= H.id //H.id is important
	if(client)
		client.screen -= H
	update_health_elements()

/mob/living/proc/restore_health_elements()
	if(!client)
		return

	for(var/k in health_elements)
		var/obj/hud/button/H = health_elements[k]
		client.screen += H

	update_health_elements()

/mob/living/proc/update_health_elements()
	if(client)
		client.known_health_elements = health_elements.Copy()

/mob/living/proc/update_health_element_icons(var/health=FALSE,var/stamina=FALSE,var/mana=FALSE)

	if(!src.client)
		return FALSE

	if(health && health_elements["health"])
		var/obj/hud/button/health/H = health_elements["health"]
		H.update_stats(src)
		H.update_sprite()

	if(stamina && health_elements["stamina"])
		var/obj/hud/button/health/S = health_elements["stamina"]
		S.update_stats(src)
		S.update_sprite()

	if(mana && health_elements["mana"])
		var/obj/hud/button/health/M = health_elements["mana"]
		M.update_stats(src)
		M.update_sprite()

	if(length(screen_blood))
		for(var/k in screen_blood)
			var/obj/hud/screen_blood/SB = k
			SB.update_stats()

	return TRUE

/mob/living/proc/check_death()

	if(!health || immortal)
		return FALSE

	var/health_added = 0
	if(has_status_effect(ADRENALINE))
		health_added = get_status_effect_magnitude(ADRENALINE)

	var/trait/death_check/DC = get_trait_by_category(/trait/death_check)
	if(DC) health_added += DC.extra_health

	if((health.health_current + health_added) <= death_threshold)
		return TRUE

	return FALSE

/mob/living/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	var/total_bleed_damage = SAFENUM(damage_table[BLADE])*2.5 + SAFENUM(damage_table[BLUNT])*0.75 + SAFENUM(damage_table[PIERCE])*1.5

	var/trait/bleed_multiplier/BM = get_trait_by_category(/trait/bleed_multiplier)
	if(BM) total_bleed_damage *= BM.bleed_multiplier

	var/savage_hit = !immortal && health ? damage_amount >= health.health_max*DT.savage_hit_threshold : FALSE

	if(savage_hit)
		total_bleed_damage *= 3
		src.on_savage_hit(atom_damaged,attacker,weapon,DT,damage_table,damage_amount,critical_hit_multiplier,stealthy)
		if(!src.dead)
			src.visible_message(span("warning","\The [src.name] takes a savage hit!"),span("danger","You take a savage hit!"))

	if(blood_type && total_bleed_damage > 0 && blood_volume > 0)
		var/turf/T = get_turf(src)
		var/reagent/R = REAGENT(blood_type)
		new /obj/effect/temp/impact/blood(T,3,R.color)
		var/offset_x = (src.x - attacker.x)
		var/offset_y = (src.y - attacker.y)

		if(!offset_x && !offset_y)
			offset_x = pick(-1,1)
			offset_y = pick(-1,1)

		var/norm_offset = max(abs(offset_x),abs(offset_y),1)
		offset_x = (offset_x/norm_offset) * total_bleed_damage * 0.25
		offset_y = (offset_y/norm_offset) * total_bleed_damage * 0.25

		for(var/i=1,i<=clamp(round(total_bleed_damage/50),1,BLOOD_LIMIT),i++)
			if(!create_blood(/obj/effect/cleanable/blood/splatter,T,R.color,offset_x,offset_y))
				break

		for(var/i=1,i<=total_bleed_damage/10,i++)
			if(!create_blood(/obj/effect/cleanable/blood/splatter_small,T,R.color,offset_x + rand(-32,32),offset_y + rand(-32,32)))
				break

		if(health && total_bleed_damage)
			blood_volume -= FLOOR(total_bleed_damage*0.02,1)
			queue_health_update = TRUE

	if(ai)
		ai.on_damage_received(atom_damaged,attacker,weapon,DT,damage_table,damage_amount,stealthy)

	if(dead && time_of_death + 30 <= world.time && (override_butcher || length(butcher_contents)) && is_living(attacker) && get_dist(attacker,src) <= 1)
		var/mob/living/L = attacker
		var/blade_damage = SAFENUM(damage_table[BLADE]) + SAFENUM(damage_table[LASER])
		if(blade_damage > 0 && src.can_be_butchered(L,weapon))
			L.visible_message(span("danger","\The [L.name] starts to butcher \the [src.name]!"),span("danger","You start to butcher \the [src.name]!"))
			PROGRESS_BAR(L,L,max(10,src.health.health_max*0.05),.proc/butcher,src)
			PROGRESS_BAR_CONDITIONS(L,src,.proc/can_be_butchered,L,weapon)

	if(!dead && has_status_effect(PARRIED))
		var/stun_duration = get_status_effect_duration(STUN)*2
		var/stun_magnitude = get_status_effect_magnitude(STUN)*2
		remove_status_effect(PARRIED)
		add_status_effect(STUN,stun_magnitude,stun_duration)

/mob/living/proc/can_be_butchered(var/mob/caller,var/obj/item/butchering_item)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(butchering_item)

	if(!src.dead)
		to_chat(span("danger","OH FUCK THEY'RE STILL ALIVE!"))
		return FALSE

	return TRUE

/mob/living/proc/butcher(var/mob/living/target)

	if(target.qdeleting)
		return FALSE

	src.visible_message(span("danger","\The [src.name] butchers \the [target.name]!"),span("danger","You butcher \the [target.name]."))

	var/turf/T = get_turf(target)

	if(target.override_butcher)
		target.create_override_contents(src)
	else
		for(var/k in target.butcher_contents)
			var/obj/O = new k(T)
			INITIALIZE(O)
			GENERATE(O)
			FINALIZE(O)

	for(var/k in target.contents)
		var/atom/movable/M = k
		if(is_organ(M))
			continue
		M.force_move(T)

	qdel(target)

	return TRUE

/mob/living/proc/get_damage_received_multiplier(var/atom/attacker,var/atom/victim,var/atom/weapon,var/atom/hit_object,var/atom/blamed,var/damagetype/DT)
	return damage_received_multiplier

/mob/living/proc/create_override_contents(var/mob/living/caller)
	return TRUE


/mob/living/proc/on_savage_hit(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	var/best_attribute = null
	var/best_damage = 0

	for(var/k in damage_table)
		var/v = damage_table[k]
		if(v > best_damage)
			best_attribute = k
			best_damage = v

	if(!best_attribute)
		return FALSE

	var/turf/T = get_turf(src)

	switch(best_attribute)
		if(BLADE)
			add_status_effect(STAGGER,10,10)
			play_sound('sound/effects/impacts/savage_blade.ogg',T,volume=80)
			if(blood_type)
				var/reagent/R = REAGENT(blood_type)
				for(var/i=1,i<=rand(3,5),i++)
					create_blood(/obj/effect/cleanable/blood/splatter/,T,R.color,rand(-TILE_SIZE*3,TILE_SIZE*3),rand(-TILE_SIZE*3,TILE_SIZE*3))
		if(BLUNT)
			add_status_effect(STAGGER,20,20)
			play_sound('sound/effects/impacts/savage_blunt.ogg',T,volume=80)
			if(blood_type)
				var/reagent/R = REAGENT(blood_type)
				for(var/i=1,i<=3,i++)
					var/obj/effect/temp/mist/M = new(T,40)
					M.color = R.color
					M.alpha = 200
					animate(M,pixel_x=rand(-16,16),pixel_y=rand(-16,16),alpha=0,time=40,easing=QUAD_EASING|EASE_OUT)
		if(PIERCE)
			add_status_effect(STAGGER,5,5)
			play_sound('sound/effects/impacts/savage_pierce.ogg',T,volume=80)
			if(blood_type)
				var/reagent/R = REAGENT(blood_type)
				var/desired_direction = get_dir(weapon,src)
				for(var/i=1,i<=4,i++)
					T = get_step(T,desired_direction)
					if(!T.is_safe_teleport())
						break
					var/obj/effect/cleanable/blood/line/L = create_blood(/obj/effect/cleanable/blood/line,T,R.color,0,0)
					if(L) L.dir = desired_direction
		if(LASER)
			play_sound('sound/effects/impacts/savage_laser.ogg',T,volume=80)
		if(ARCANE)
			add_status_effect(MANAVOID,10,10)
			play_sound('sound/effects/impacts/savage_arcane.ogg',T,volume=80)
		if(HEAT)
			ignite(30,source=weapon)
			play_sound('sound/effects/impacts/savage_fire.ogg',T,volume=80)
		if(COLD)
			add_status_effect(SLOW,50,50)
			play_sound('sound/effects/impacts/savage_cold.ogg',T,volume=80)
		if(SHOCK)
			add_status_effect(ADRENALINE,100,100)
			add_status_effect(STUN,10,10)
			play_sound('sound/effects/impacts/savage_shock.ogg',T,volume=80)
		if(BOMB)
			play_sound('sound/effects/impacts/savage_bomb.ogg',T,volume=80)
			bang(30)
		if(BIO)
			add_status_effect(BLIGHTED,100,100)
			play_sound('sound/effects/impacts/savage_bio.ogg',T,volume=80)
		if(RAD)
			//TODO: Add radiation bubbles?.
			play_sound('sound/effects/impacts/savage_rad.ogg',T,volume=80)
		if(HOLY)
			add_status_effect(CONSECRATED,300,300)
			play_sound('sound/effects/impacts/savage_holy.ogg',T,volume=80)
		if(DARK)
			add_status_effect(CURSED,300,300)
			play_sound('sound/effects/impacts/savage_dark.ogg',T,volume=80)
		if(FATIGUE)
			add_status_effect(SLOW,50,50)
			play_sound('sound/effects/impacts/savage_fatigue.ogg',T,volume=80)
		if(PAIN)
			add_status_effect(STUN,30,30)
			play_sound('sound/effects/impacts/savage_pain.ogg',T,volume=80)
		if(ION)
			add_status_effect(PARALYZE,30,30)
			play_sound('sound/effects/impacts/savage_ion.ogg',T,volume=80)
		if(SANITY)
			add_status_effect(PARALYZE,30,30)
			play_sound('sound/effects/impacts/savage_sanity.ogg',T,volume=80)




	return TRUE