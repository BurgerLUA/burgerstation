/obj/item/pinpointer/
	name = "personal pinpointer"
	desc = "Where is it?"
	desc_extended = "Use this to track and locate objects."

	icon = 'icons/obj/items/pinpointer.dmi'
	icon_state = "red"

	var/atom/tracked_atom

	var/scan_mode = FALSE

	value = 10

/obj/item/pinpointer/get_examine_list(var/mob/caller)

	. = ..()

	if(tracked_atom)
		var/turf/T = get_turf(tracked_atom)
		var/turf/T2 = get_turf(src)
		. += div("notice","The device reports the coordinates as ([T2.x],[T2.y],[T2.z]).")
		. += div("notice","It's set to track [tracked_atom.name] at ([T.x],[T.y],[T.z]).")
	else
		. += div("notice","It's off.")

	return .

/obj/item/pinpointer/proc/can_track(var/atom/A)

	if(!A)
		return FALSE

	var/turf/T = get_turf(A)
	if(!T)
		return FALSE

	var/turf/T2 = get_turf(src)
	if(!T2)
		return FALSE

	if(!A || A.qdeleting || T.z != T2.z)
		return FALSE

	return TRUE

/obj/item/pinpointer/Initialize()
	update_sprite()
	return ..()

/obj/item/pinpointer/update_underlays()
	if(!length(underlays))
		var/image/I = new/image(initial(icon),initial(icon_state))
		underlays += I
	return TRUE

/obj/item/pinpointer/Destroy()
	tracked_atom = null
	return ..()

/obj/item/pinpointer/update_icon()

	. = ..()

	if(scan_mode)
		icon_state = "scan"
	else if(tracked_atom)
		var/distance = get_dist(tracked_atom,src)
		var/desired_dir = get_dir(src,tracked_atom)
		switch(distance)
			if(0)
				icon_state = "direct"
			if(VIEW_RANGE*0.5)
				icon_state = "[desired_dir]_close"
			if(VIEW_RANGE*0.5 to VIEW_RANGE)
				icon_state = "[desired_dir]_med"
			if(VIEW_RANGE to 255)
				icon_state = "[desired_dir]_far"
	else
		icon_state = "null"

	return .

/obj/item/pinpointer/think()

	if(scan_mode || !can_track(tracked_atom) )
		tracked_atom = null

	update_sprite()

	return TRUE

/obj/item/pinpointer/custom/
	name = "custom pinpointer"
	icon_state = "brown"

	value = 30

/obj/item/pinpointer/custom/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(scan_mode && object)
		if(!can_track(object))
			caller.to_chat(span("warning","You can't track this object!"))
			return TRUE
		tracked_atom = object
		caller.to_chat(span("notice","You scan \the [object], tracking it."))
		scan_mode = FALSE
		start_thinking(src)
		return TRUE

	return ..()

/obj/item/pinpointer/custom/click_self(var/mob/caller)

	scan_mode = !scan_mode

	if(scan_mode)
		caller.to_chat(span("notice","You enable scan mode. Scan an object to track it."))
	else
		caller.to_chat(span("notice","You disable scan mode."))

	update_sprite()

	return TRUE


/obj/item/pinpointer/crew/
	name = "crew pinpointer"
	icon_state = "blue"

	value = 20

/obj/item/pinpointer/crew/click_self(var/mob/caller)

	var/list/possible_crew = list()

	for(var/mob/living/advanced/player/P in all_mobs_with_clients)
		possible_crew[P.name] = P

	scan_mode = TRUE
	update_sprite()

	var/choice = input("Who do you want to track?","Crew Pinpointer Tracking",null) as null|anything in possible_crew

	if(choice)
		var/mob/living/advanced/player/P = possible_crew[choice]
		tracked_atom = P
	else
		tracked_atom = null

	scan_mode = FALSE
	start_thinking(src)

	return TRUE

/obj/item/pinpointer/landmark/
	name = "landmark pinpointer"
	icon_state = "green"

	value = 10

/obj/item/pinpointer/landmark/click_self(var/mob/caller)

	var/list/possible_landmarks = list()

	for(var/obj/marker/landmark/L in all_landmarks)
		if(!can_track(L))
			continue
		possible_landmarks[L.name] = L

	if(!length(possible_landmarks))
		caller.to_chat(span("warning","Can't find anything to track!"))
		return TRUE

	scan_mode = TRUE
	update_sprite()

	var/choice = input("What do you want to track?","Landmark Pinpointer Tracking","Cancel") as null|anything in possible_landmarks

	if(choice)
		var/obj/marker/landmark/L = possible_landmarks[choice]
		tracked_atom = L
	else
		tracked_atom = null

	scan_mode = FALSE
	start_thinking(src)

	return TRUE

/obj/item/pinpointer/artifact/
	name = "artifact pinpointer"
	icon_state = "yellow"

	value = 20

/obj/item/pinpointer/artifact/click_self(var/mob/caller)

	var/list/possible_artifacts = list()

	for(var/obj/structure/interactive/objective/O in SShorde.tracked_objectives)
		if(!can_track(O))
			continue
		var/name_mod = "[O.name] ([get_dist(src,O)]m)"
		possible_artifacts[name_mod] = O

	if(!length(possible_artifacts))
		caller.to_chat(span("warning","Can't find anything to track!"))
		return TRUE

	scan_mode = TRUE
	update_sprite()

	var/choice = input("What do you want to track?","Artifact Pinpointer Tracking","Cancel") as null|anything in possible_artifacts

	if(choice)
		var/obj/structure/interactive/objective/O = possible_artifacts[choice]
		tracked_atom = O
	else
		tracked_atom = null

	scan_mode = FALSE
	start_thinking(src)

	return TRUE