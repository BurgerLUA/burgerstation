/mob/living/proc/add_health_element(var/obj/hud/button/health/H)
	health_elements[H.id] = H
	if(client)
		client.screen += H
	update_health_elements()

/mob/living/proc/remove_health_element(var/obj/hud/button/health/H)
	health_elements -= H
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

/mob/living/proc/update_health_element_icons(var/health=FALSE,var/stamina=FALSE,var/mana=FALSE,var/update_body=FALSE)

	if(!src.client)
		return FALSE

	if(health && health_elements["health"])
		var/obj/hud/button/health/H = health_elements["health"]
		H.update_stats(src)

	if(stamina && health_elements["stamina"])
		var/obj/hud/button/health/S = health_elements["stamina"]
		S.update_stats(src)

	if(mana && health_elements["mana"])
		var/obj/hud/button/health/M = health_elements["mana"]
		M.update_stats(src)

	if(length(screen_blood))
		for(var/k in screen_blood)
			var/obj/hud/screen_blood/SB = k
			SB.update_stats()

	return TRUE

/mob/living/proc/check_death()

	if(!health)
		return FALSE

	var/health_added = 0
	if(has_status_effect(ADRENALINE))
		health_added = get_status_effect_magnitude(ADRENALINE)

	if( (health.health_current + health_added) <= death_threshold)
		return TRUE

	return FALSE

/mob/living/proc/should_bleed()
	return TRUE

/mob/living/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	var/total_bleed_damage = SAFENUM(damage_table[BLADE])*2 + SAFENUM(damage_table[BLUNT])*0.5 + SAFENUM(damage_table[PIERCE])

	if(blood_type && total_bleed_damage && should_bleed() && luck(src,total_bleed_damage,FALSE))

		if(blood_volume > 0)
			var/offset_x = (src.x - attacker.x)
			var/offset_y = (src.y - attacker.y)

			if(!offset_x && !offset_y)
				offset_x = pick(-1,1)
				offset_y = pick(-1,1)

			var/norm_offset = max(abs(offset_x),abs(offset_y),1)
			offset_x = (offset_x/norm_offset) * total_bleed_damage * 0.25
			offset_y = (offset_y/norm_offset) * total_bleed_damage * 0.25

			var/reagent/R = REAGENT(blood_type)

			for(var/i=1,i<=clamp(round(total_bleed_damage/50),1,BLOOD_LIMIT),i++)
				if(!create_blood(/obj/effect/cleanable/blood/splatter,get_turf(src),R.color,offset_x,offset_y))
					break

			for(var/i=1,i<=total_bleed_damage/10,i++)
				if(!create_blood(/obj/effect/cleanable/blood/splatter_small,get_turf(src),R.color,offset_x + rand(-32,32),offset_y + rand(-32,32)))
					break

			if(health && total_bleed_damage)
				blood_volume -= FLOOR(total_bleed_damage*0.03,1)
				queue_health_update = TRUE

		if(is_organ(atom_damaged))
			var/obj/item/organ/O = atom_damaged
			var/bleed_to_add = total_bleed_damage/25
			O.bleeding += bleed_to_add

	if(ai)
		ai.on_damage_received(atom_damaged,attacker,weapon,damage_table,damage_amount,stealthy)

	if(dead && time_of_death + 30 <= world.time && (override_butcher || length(butcher_contents)) && is_living(attacker) && get_dist(attacker,src) <= 1)
		var/mob/living/L = attacker
		var/blade_damage = SAFENUM(damage_table[BLADE]) + SAFENUM(damage_table[LASER])
		if(blade_damage > 0 && src.can_be_butchered(L,weapon))
			L.visible_message(span("danger","\The [L.name] starts to butcher \the [src.name]!"),span("danger","You start to butcher \the [src.name]!"))
			PROGRESS_BAR(L,L,max(10,src.health.health_max*0.05),.proc/butcher,src)
			PROGRESS_BAR_CONDITIONS(L,src,.proc/can_be_butchered,L,weapon)

	if(!dead && has_status_effect(STAGGER))
		var/stagger_duration = get_status_effect_duration(STUN)*2
		var/stagger_magnitude = get_status_effect_magnitude(STUN)*2
		remove_status_effect(STAGGER)
		add_status_effect(STUN,stagger_magnitude,stagger_duration)

	return .

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