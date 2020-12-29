/obj/item/pinpointer/
	name = "personal pinpointer"
	desc = "Where is it?"
	desc_extended = "Use this to track and locate objects."

	icon = 'icons/obj/item/pinpointer.dmi'
	icon_state = "red"

	var/atom/tracked_atom

	var/scan_mode = FALSE

	value = 10

	weight = 2

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

	var/area/A1 = get_area(A)
	var/area/A2 = get_area(src)

	if(A1.area_identifier != A2.area_identifier)
		return FALSE

	return TRUE

/obj/item/pinpointer/PostInitialize()
	. = ..()
	update_sprite()
	return .

/obj/item/pinpointer/update_underlays()
	. = ..()
	if(!length(underlays))
		var/image/I = new/image(initial(icon),initial(icon_state))
		underlays += I
	return .

/obj/item/pinpointer/Destroy()
	tracked_atom = null
	return ..()

/obj/item/pinpointer/update_icon()

	. = ..()

	if(scan_mode)
		icon_state = "scan"
	else if(tracked_atom)
		var/distance = get_dist(src,tracked_atom)
		var/desired_dir = get_dir(src,tracked_atom)
		switch(distance)
			if(1 to VIEW_RANGE*0.5)
				icon_state = "[desired_dir]_close"
			if(VIEW_RANGE*0.5 to VIEW_RANGE)
				icon_state = "[desired_dir]_med"
			if(VIEW_RANGE to 255)
				icon_state = "[desired_dir]_far"
			else
				icon_state = "direct"
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
	desc_extended = "Use this to track and locate objects. This one allows you to scan an object and then track it."
	icon_state = "brown"

	value = 30

/obj/item/pinpointer/custom/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(scan_mode && object)
		INTERACT_CHECK
		INTERACT_DELAY(10)
		if(!can_track(object))
			caller.to_chat(span("warning","You can't track this object!"))
			return TRUE
		tracked_atom = object
		caller.visible_message(span("notice","\The [caller.name] scans \the [object.name] with \the [src.name]."),span("notice","You scan \the [object.name], tracking it."))
		scan_mode = FALSE
		start_thinking(src)
		return TRUE

	return ..()

/obj/item/pinpointer/custom/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	scan_mode = !scan_mode

	if(scan_mode)
		caller.to_chat(span("notice","You enable scan mode. Scan an object to track it."))
	else
		caller.to_chat(span("notice","You disable scan mode."))

	update_sprite()

	return TRUE


/obj/item/pinpointer/crew/
	name = "crew pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks positions of NanoTrasen crew."
	icon_state = "blue"

	value = 20

	var/desired_loyalty = "NanoTrasen"

	var/encoded = TRUE

/obj/item/pinpointer/crew/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	var/list/possible_crew = list()

	if(encoded && is_living(caller))
		var/mob/living/L = caller
		if(L.loyalty_tag != desired_loyalty)
			caller.to_chat(span("warning","All the information seems to be displayed in code you don't understand..."))
			return FALSE

	for(var/mob/living/advanced/player/P in all_players)
		if(P.loyalty_tag != desired_loyalty)
			continue
		if(!can_track(P))
			continue
		var/name_mod = "[P.real_name] ([P.dead ? "DEAD" : "Alive"], [dir2text(get_dir(caller,P))], [get_dist(src,P)]m)"
		possible_crew[name_mod] = P

	scan_mode = TRUE
	update_sprite()

	var/choice = input("Who do you want to track?","Crew Pinpointer Tracking",null) as null|anything in possible_crew

	INTERACT_CHECK_OTHER(src) //Hacky

	if(choice)
		var/mob/living/advanced/player/P = possible_crew[choice]
		tracked_atom = P
	else
		tracked_atom = null

	scan_mode = FALSE
	start_thinking(src)

	return TRUE

/obj/item/pinpointer/crew/syndicate
	name = "syndicate pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks positions of Syndicate Raiders."
	icon_state = "red"
	desired_loyalty = "Syndicate"
	value = 1000
	encoded = TRUE

/obj/item/pinpointer/landmark/
	name = "area pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks positions of important areas."
	icon_state = "green"

	value = 10

/obj/item/pinpointer/landmark/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	var/list/possible_landmarks = list()

	var/area/my_area = get_area(src)
	if(!my_area.area_identifier)
		caller.to_chat(span("warning","There is no signal..."))
		return TRUE

	for(var/k in SSarea.all_areas)
		var/area/A = SSarea.all_areas[k]
		if(A.z != caller.z)
			continue
		if(!A.trackable)
			continue
		if(my_area.area_identifier != A.area_identifier)
			continue
		var/turf/T = locate(A.average_x,A.average_y,A.z)
		var/name_mod = "[A.name] ([dir2text(get_dir(caller,T))], [get_dist(src,T)]m)"
		possible_landmarks[name_mod] = T

	if(!length(possible_landmarks))
		caller.to_chat(span("warning","Can't find anything to track!"))
		return TRUE

	scan_mode = TRUE
	update_sprite()

	var/choice = input("What do you want to track?","Area Pinpointer Tracking","Cancel") as null|anything in possible_landmarks

	INTERACT_CHECK_OTHER(src) //Hacky

	if(choice)
		var/turf/T = possible_landmarks[choice]
		tracked_atom = T
	else
		tracked_atom = null

	scan_mode = FALSE
	start_thinking(src)

	return TRUE

/obj/item/pinpointer/artifact/
	name = "objectives pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks positions of your objectives, only works when in the field."
	icon_state = "yellow"

	value = 20

/obj/item/pinpointer/artifact/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	var/list/possible_artifacts = list()

	for(var/v in SSgamemode.active_gamemode.crew_active_objectives)
		var/objective/O = v
		if(!O.trackable)
			continue
		for(var/k in O.tracked_atoms)
			var/atom/A = k
			if(!can_track(A))
				continue
			var/name_mod = "[A.name] ([dir2text(get_dir(caller,A))], [get_dist(src,A)]m)"
			possible_artifacts[name_mod] = A

	if(!length(possible_artifacts))
		caller.to_chat(span("warning","Can't find anything to track!"))
		return TRUE

	scan_mode = TRUE
	update_sprite()

	var/choice = input("What do you want to track?","Objective Pinpointer Tracking","Cancel") as null|anything in possible_artifacts

	INTERACT_CHECK_OTHER(src) //Hacky

	if(choice)
		var/atom/A = possible_artifacts[choice]
		tracked_atom = A
	else
		tracked_atom = null

	scan_mode = FALSE
	start_thinking(src)

	return TRUE


/obj/item/pinpointer/boss/
	name = "boss pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks positions of the big bad, only works when in the field."
	icon_state = "orange"

	value = 100

/obj/item/pinpointer/boss/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	var/list/possible_bosses = list()

	for(var/k in SSbosses.tracked_bosses)
		var/atom/A = k
		if(!can_track(A))
			continue
		var/name_mod = "[A.name] ([dir2text(get_dir(caller,A))], [get_dist(src,A)]m)"
		possible_bosses[name_mod] = A

	if(!length(possible_bosses))
		caller.to_chat(span("warning","Can't find anything to track!"))
		return TRUE

	scan_mode = TRUE
	update_sprite()

	var/choice = input("What do you want to track?","Objective Pinpointer Tracking","Cancel") as null|anything in possible_bosses

	INTERACT_CHECK_OTHER(src) //Hacky.

	if(choice)
		var/atom/A = possible_bosses[choice]
		tracked_atom = A
	else
		tracked_atom = null

	scan_mode = FALSE
	start_thinking(src)

	return TRUE