/obj/item/emf
	name = "\improper EMF reader"
	desc = "It just works."
	desc_extended = "A specialized plastic tool that can allegedly read Electromagnetic Field Radiation levels. Allegedly."
	icon = 'icons/obj/item/weapons/melee/tools/emf.dmi'
	icon_state = "inventory"

	value = 50

	var/emf_level = 0
	var/active = FALSE

	weight = 1

/obj/item/emf/proc/set_emf_level(var/desired_level)

	if(desired_level == emf_level)
		return FALSE

	emf_level = desired_level

	if(emf_level > 0)
		start_thinking(src)
	else
		stop_thinking(src)

	update_sprite()

	return TRUE

/obj/item/emf/proc/on_emf_think()

	if(!active)
		return FALSE

	var/turf/T1 = get_turf(src)

	if(!T1)
		return FALSE

	emf_level = 0

	var/mob/living/simple/ghost/G1 = locate() in range(6,T1)
	if(G1)
		if(G1.ai && G1.ai.objective_attack)
			emf_level = 5
		else
			emf_level = 3
	else
		var/mob/abstract/observer/G2 = locate() in range(3,T1)
		if(G2) emf_level = 2

	for(var/k in SSghost.all_emfs)
		var/obj/emf/E = k
		var/turf/T2 = get_turf(E)
		if(!T2)
			log_error("Warning: Invalid EMF location found for [E.get_debug_name()].")
			continue
		if(T1.z != T2.z)
			continue
		var/distance = get_dist(T1,T2)
		if(distance > E.emf_range)
			continue
		emf_level = max(emf_level,min((1 - (distance/E.emf_range))*E.emf_level*2,E.emf_level))

	emf_level = clamp(emf_level,1,5)
	update_sprite()

	if(emf_level >= 3)
		play_sound('sound/effects/warning_chime.ogg', T1, volume=45+emf_level*5, pitch = 0.9 + emf_level*0.1,range_max=VIEW_RANGE)

	return TRUE


/obj/item/emf/New(var/desired_loc)
	. = ..()
	SSghost.all_emf_trackers += src
	return .

/obj/item/emf/Destroy()
	SSghost.all_emf_trackers -= src
	return ..()

/obj/item/emf/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(10)
	SPAM_CHECK(3)

	active = !active

	caller.to_chat(span("notice","You turn [active ? "on" : "off"] \the [src.name]."))

	play_sound('sound/machines/click.ogg',get_turf(src),range_max=VIEW_RANGE*0.25)

	if(active)
		if(emf_level) start_thinking(src)
	else
		stop_thinking(src)

	update_sprite()

	return TRUE

/obj/item/emf/update_icon()
	icon = initial(icon)
	icon_state = initial(icon_state)
	if(active)
		icon_state = "[icon_state]_[clamp(CEILING(emf_level,1),1,5)]"

	return ..()