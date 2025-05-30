/obj/item/pinpointer/
	name = "personal pinpointer"
	desc = "Where is it?"
	desc_extended = "Use this to track and locate objects."

	icon = 'icons/obj/item/pinpointer.dmi'
	icon_state = "red"

	var/atom/tracked_atom

	var/scan_mode = FALSE

	var/signal_offset

	value = 10

	weight = 2
	has_quick_function = TRUE

	var/unreliable = FALSE

	rarity = RARITY_UNCOMMON

/obj/item/pinpointer/quick(var/mob/activator,var/atom/object,location,params)
	return click_self(activator)

/obj/item/pinpointer/Destroy()
	tracked_atom = null
	. = ..()

/obj/item/pinpointer/get_examine_list(var/mob/activator)

	. = ..()

	if(tracked_atom)
		var/turf/T = get_turf(tracked_atom)
		var/turf/T2 = get_turf(src)
		. += div("notice","The device reports the coordinates as ([T2.x],[T2.y],[T2.z]).")
		. += div("notice","It's set to track [tracked_atom.name] at ([T.x],[T.y],[T.z]).")
	else
		. += div("notice","It's off.")


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

/obj/item/pinpointer/update_underlays()
	. = ..()
	if(!length(underlays))
		var/image/I = new/image(initial(icon),initial(icon_state))
		underlays += I

/obj/item/pinpointer/update_icon()

	. = ..()

	if(scan_mode)
		icon_state = "scan"
	else if(tracked_atom)
		var/turf/T1 = get_turf(src)
		var/turf/T2 = get_turf(tracked_atom)
		var/distance = get_dist_advanced(T1,T2)
		if(unreliable)
			var/rand_num = rand(5,10)
			distance = 	CEILING(distance,rand_num)
			distance += rand(5,10)
		var/desired_dir = get_dir_advanced(T1,T2)
		switch(distance)
			if(1 to VIEW_RANGE*0.5)
				icon_state = "[desired_dir]_close"
			if(VIEW_RANGE*0.5 to VIEW_RANGE)
				icon_state = "[desired_dir]_med"
			if(VIEW_RANGE to INFINITY)
				icon_state = "[desired_dir]_far"
			else
				icon_state = "direct"
	else
		icon_state = "null"


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

/obj/item/pinpointer/custom/click_on_object(var/mob/activator as mob,var/atom/object,location,control,params)

	if(scan_mode && object)
		INTERACT_CHECK
		INTERACT_DELAY(10)
		if(!can_track(object))
			activator.to_chat(span("warning","You can't track this object!"))
			return TRUE
		tracked_atom = object
		activator.visible_message(span("notice","\The [activator.name] scans \the [object.name] with \the [src.name]."),span("notice","You scan \the [object.name], tracking it."))
		scan_mode = FALSE
		START_THINKING(src)
		return TRUE

	return ..()

/obj/item/pinpointer/custom/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	scan_mode = !scan_mode

	if(scan_mode)
		activator.to_chat(span("notice","You enable scan mode. Scan an object to track it."))
	else
		activator.to_chat(span("notice","You disable scan mode."))

	update_sprite()

	return TRUE


/obj/item/pinpointer/crew/
	name = "crew pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks positions of NanoTrasen crew."
	icon_state = "blue"

	value = 20

	var/desired_loyalty_tag = "NanoTrasen"

	var/encoded = TRUE

	rarity = RARITY_RARE

/obj/item/pinpointer/crew/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	var/list/possible_crew = list()

	if(enable_friendly_fire)
		activator.to_chat(span("notice","This doesn't seem to be working for some reason..."))
		return FALSE

	if(encoded && is_living(activator))
		var/mob/living/L = activator
		if(L.loyalty_tag != desired_loyalty_tag)
			activator.to_chat(span("warning","All the information seems to be displayed in code you don't understand..."))
			return FALSE

	for(var/mob/living/advanced/player/P in SSliving.all_players)
		if(P.loyalty_tag != desired_loyalty_tag)
			continue
		if(!can_track(P))
			continue
		var/name_mod = "[P.real_name] ([P.dead ? "DEAD" : "Alive"], [dir2text(get_dir_advanced(activator,P))], [get_dist_advanced(src,P)]m)"
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
	START_THINKING(src)

	return TRUE


/obj/item/pinpointer/crew/death
	name = "death pinpointer"
	icon_state = "grey"
	desc_extended = "Use this to track and locate objects. This is used to exclusively track corpses of NanoTrasen Crew."
	value = 100

/obj/item/pinpointer/crew/death/can_track(var/atom/A)

	var/mob/living/advanced/player/P = A
	if(!istype(P))
		return FALSE

	if(!P.dead)
		return FALSE

	. = ..()


/obj/item/pinpointer/crew/syndicate
	name = "syndicate operative pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks positions of Syndicate Raiders."
	icon_state = "syndicate"
	desired_loyalty_tag = "Syndicate"
	value = 1000
	encoded = TRUE
	can_save = FALSE

/obj/item/pinpointer/crew/revolutionary
	name = "revolutionary soldier pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks positions of Revolutionary Soldiers."
	icon_state = "rev"
	desired_loyalty_tag = "Revolutionary"
	value = 1000
	encoded = TRUE
	can_save = FALSE

/obj/item/pinpointer/landmark/
	name = "area pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks positions of important areas."
	icon_state = "green"

	value = 10

/obj/item/pinpointer/landmark/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	var/list/possible_landmarks = list()

	var/area/my_area = get_area(src)
	if(!my_area.area_identifier)
		activator.to_chat(span("warning","There is no signal..."))
		return TRUE

	for(var/k in SSarea.all_areas)
		var/area/A = SSarea.all_areas[k]
		if(A.z != activator.z)
			continue
		if(!A.trackable)
			continue
		if(my_area.area_identifier != A.area_identifier)
			continue
		var/turf/T = locate(A.average_x,A.average_y,A.z)
		var/name_mod = "[A.name] ([dir2text(get_dir_advanced(activator,T))], [get_dist_advanced(src,T)]m)"
		possible_landmarks[name_mod] = T

	if(!length(possible_landmarks))
		activator.to_chat(span("warning","Can't find anything to track!"))
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
	START_THINKING(src)

	return TRUE

/obj/item/pinpointer/objective/
	name = "objectives pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks positions of your objectives, only works when in the field."
	icon_state = "yellow"

	value = 20

/obj/item/pinpointer/objective/click_self(var/mob/activator,location,control,params)

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
			var/name_mod = "[A.name] ([dir2text(get_dir_advanced(activator,A))], [get_dist_advanced(src,A)]m)"
			possible_artifacts[name_mod] = A

	if(!length(possible_artifacts))
		activator.to_chat(span("warning","Can't find anything to track!"))
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
	START_THINKING(src)

	return TRUE


/obj/item/pinpointer/boss/
	name = "boss pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks positions of the big bad, only works when in the field."
	icon_state = "orange"

	value = 100

/obj/item/pinpointer/boss/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	var/list/possible_bosses = list()

	for(var/k in SSbosses.tracked_bosses)
		var/mob/living/A = k
		if(!can_track(A))
			continue
		if(!is_living(A))
			continue
		if(A.health.health_current < 0)
			continue
		var/name_mod = "[A.name] ([dir2text(get_dir_advanced(activator,A))], [get_dist_advanced(src,A)]m)"
		possible_bosses[name_mod] = A

	if(!length(possible_bosses))
		activator.to_chat(span("warning","Can't find anything to track!"))
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
	START_THINKING(src)

	return TRUE



/obj/item/pinpointer/deathmatch
	name = "deathmatch pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks everyone, but not that well.."
	icon_state = "syndicate"
	value = 1000
	value_burgerbux = 1
	unreliable = TRUE
	can_save = FALSE

/obj/item/pinpointer/deathmatch/click_self(var/mob/activator,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	var/list/possible_crew = list()

	if(!enable_friendly_fire)
		activator.to_chat(span("notice","This doesn't seem to be working for some reason..."))
		return FALSE

	for(var/mob/living/advanced/player/P in SSliving.all_players)
		if(!can_track(P))
			continue
		var/signal_num = text2num("\ref[P]",16)
		signal_num += signal_offset
		signal_num = 1 + (signal_num % 200)
		var/rand_num = rand(5,10)
		var/distance_to_show = 	CEILING(get_dist_advanced(src,P),rand_num)
		var/name_mod = "Signal #[signal_num] ([P.dead ? "DEAD" : "Alive"], ~[distance_to_show]m)"
		possible_crew[name_mod] = P

	scan_mode = TRUE
	update_sprite()

	var/choice = input("Who do you want to track?","Deathmatch Pinpointer Tracking",null) as null|anything in possible_crew

	INTERACT_CHECK_OTHER(src) //Hacky

	if(choice)
		var/mob/living/advanced/player/P = possible_crew[choice]
		tracked_atom = P
	else
		tracked_atom = null

	scan_mode = FALSE
	START_THINKING(src)

	return TRUE



/obj/item/pinpointer/mobs
	name = "enemy pinpointer"
	desc_extended = "Use this to track and locate objects. This one tracks things to kill."
	icon_state = "syndicate"
	value = 1000
	value_burgerbux = 1

	rarity = RARITY_MYTHICAL

/obj/item/pinpointer/mobs/click_self(var/mob/activator, var/mob/living/advanced/npc/a, var/mob/living/simple/a)
	INTERACT_CHECK
	INTERACT_DELAY(1)

	var/list/mobs = list()
	for(a in SSliving.all_mobs)
		if(!can_track(a))
			continue
		var/signal_num = text2num("\ref[a]",16)
		signal_num += signal_offset
		signal_num = 1 + (signal_num % 200)
		var/distance_to_show = get_dist_advanced(src,a)
		var/name_mod = "[a.name] ([a.dead ? "DEAD" : "Alive"], ~[distance_to_show]m)"
		mobs[name_mod] = a

	scan_mode = TRUE
	update_sprite()

	var/choice = input("Who do you want to track?","Mob Pinpointer Tracking",null) as null|anything in mobs

	INTERACT_CHECK_OTHER(src) //Hacky

	if(choice)
		a = mobs[choice]
		tracked_atom = a
	else
		tracked_atom = null

	scan_mode = FALSE
	START_THINKING(src)

	return TRUE
