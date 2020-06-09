/mob/living/proc/add_health_element(var/obj/hud/button/H)
	health_elements[H.id] = H
	if(client)
		client.screen += H
	update_health_elements()

/mob/living/proc/remove_health_element(var/obj/hud/button/H)
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
		for(var/obj/hud/screen_blood/SB in screen_blood)
			SB.update_stats()

	return TRUE

/mob/living/proc/check_death()

	if(!health)
		return FALSE

	var/health_added = 0
	if(has_status_effect(ADRENALINE))
		health_added = get_status_effect_magnitude(ADRENALINE)

	if(health.health_current + health_added <= death_threshold)
		return TRUE

	return FALSE

/mob/living/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/list/damage_table,var/damage_amount)

	. = ..()

	var/total_bleed_damage = SAFENUM(damage_table[BLADE])*3 + SAFENUM(damage_table[BLUNT]) + SAFENUM(damage_table[PIERCE])*2

	if(total_bleed_damage && luck(src,total_bleed_damage,FALSE))

		if(reagents.volume_current > 0)
			var/offset_x = (src.x - attacker.x)
			var/offset_y = (src.y - attacker.y)

			if(!offset_x && !offset_y)
				offset_x = pick(-1,1)
				offset_y = pick(-1,1)

			var/norm_offset = max(abs(offset_x),abs(offset_y),1)
			offset_x = (offset_x/norm_offset) * total_bleed_damage * 0.25
			offset_y = (offset_y/norm_offset) * total_bleed_damage * 0.25

			for(var/i=1,i<=clamp(round(total_bleed_damage/50),1,5),i++)
				new /obj/effect/temp/blood/splatter(src.loc,SECONDS_TO_DECISECONDS(60),reagents.color,offset_x,offset_y)

			reagents.remove_reagents(total_bleed_damage/5)

		if(is_organ(atom_damaged))
			var/obj/item/organ/O = atom_damaged
			O.bleeding = TRUE

	if(ai)
		ai.on_damage_received(atom_damaged,attacker,weapon,damage_table,damage_amount)

	if(dead && time_of_death + 30 <= world.time && length(butcher_contents) && is_living(attacker) && get_dist(attacker,src) <= 1)
		var/mob/living/L = attacker
		var/blade_damage = SAFENUM(damage_table[BLADE]) + SAFENUM(damage_table[LASER])
		var/butcher_mod = (src.health.health_max + src.health.health_current)*0.1
		if(blade_damage > max(10,butcher_mod))
			if(L.can_butcher(weapon,src))
				L.visible_message(span("danger","\The [L.name] starts to butcher \the [src.name]!"),span("danger","You start to butcher \the [src.name]!"))
				PROGRESS_BAR(L,L,max(10,src.health.health_max*0.05),.proc/butcher,src)
				PROGRESS_BAR_CONDITIONS(L,L,.proc/can_butcher,weapon,src)
		else
			L.to_chat("You weaken \the [src.name] for butchering...")

	return .

/mob/living/proc/can_butcher(var/obj/item/butcher_item,var/mob/living/butcher_target)

	if(!butcher_item || !butcher_target)
		to_chat(span("warning","You can't butcher that!"))
		return FALSE

	if(!is_inventory(butcher_item.loc))
		to_chat(span("warning","You must be holding \the [butcher_item.name] to butcher \the [butcher_target.name]!"))
		return FALSE

	if(!isturf(butcher_target.loc))
		to_chat(span("warning","You can't butcher \the [butcher_target.name] in there!"))
		return FALSE

	if(get_dist(src,butcher_target) > 1 || get_dist(src,butcher_item) > 1)
		to_chat(span("warning","You're too far way to butcher \the [butcher_target.name]!"))
		return FALSE

	if(!butcher_target.dead)
		to_chat(span("danger","OH FUCK THEY'RE STILL ALIVE!"))
		return FALSE

	return TRUE

/mob/living/proc/butcher(var/mob/living/target)

	src.visible_message(span("danger","\The [src.name] butchers \the [target.name]!"),span("danger","You butcher \the [target.name]."))

	for(var/k in target.butcher_contents)
		var/obj/O = new k(target.loc)
		INITIALIZE(O)
		GENERATE(O)

	for(var/atom/movable/M in target.contents)
		if(is_organ(M))
			continue
		M.force_move(target.loc)

	qdel(target)

	return TRUE