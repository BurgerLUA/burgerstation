/obj/item/pinpointer/
	name = "personal pinpointer"
	desc = "Where is it?"
	desc_extended = "Use this to track and locate objects."

	icon = 'icons/obj/items/pinpointer.dmi'
	icon_state = "red"

	var/atom/tracked_atom

	var/scan_mode = FALSE

	value = 10

/obj/item/pinpointer/New(var/desired_loc)

	var/image/I = new/image(initial(icon),initial(icon_state))
	underlays += I

	return ..()

/obj/item/pinpointer/Destroy()
	tracked_atom = null
	return ..()

/obj/item/pinpointer/think()

	if(tracked_atom && tracked_atom.qdeleting)
		tracked_atom = null

	if(scan_mode)
		icon_state = "scan"
	else if(tracked_atom)
		var/distance = get_dist(tracked_atom,src)
		var/desired_dir = get_dir(src,tracked_atom)
		switch(distance)
			if(0)
				icon_state = "direct"
			if(1)
				icon_state = "[desired_dir]_close"
			if(2 to VIEW_RANGE)
				icon_state = "[desired_dir]_med"
			if(VIEW_RANGE to 255)
				icon_state = "[desired_dir]_far"
			else
				tracked_atom = null

	if(!tracked_atom)
		icon_state = "null"
		update_sprite()
		return FALSE

	update_sprite()

	return ..()

/obj/item/pinpointer/custom/
	name = "custom pinpointer"
	icon_state = "yellow"

	value = 30

/obj/item/pinpointer/custom/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(scan_mode && object)
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
		var/list/caller_z = get_z_level(caller)
		var/list/L_z = get_z_level(L)
		if(L_z[1] != caller_z[1])
			continue
		if(L_z[2] != caller_z[2])
			continue
		possible_landmarks[L.name] = L

	scan_mode = TRUE
	update_sprite()

	var/choice = input("Who do you want to track?","Landmark Pinpointer Tracking","Cancel") as null|anything in possible_landmarks

	if(choice)
		var/obj/marker/landmark/L = possible_landmarks[choice]
		tracked_atom = L
	else
		tracked_atom = null

	scan_mode = FALSE
	start_thinking(src)

	return TRUE