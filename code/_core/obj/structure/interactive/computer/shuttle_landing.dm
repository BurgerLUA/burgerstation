var/global/global_shuttle_number = 0

var/global/list/obj/structure/interactive/computer/console/shuttle_landing/all_shuttle_landing_consoles = list()


/obj/structure/interactive/computer/console/shuttle_landing
	name = "shuttle landing computer"
	desc = "Block all incoming traffic, with the click of a button."
	desc_extended = "A generic shuttle landing computer that controls whether or not shuttles can land via autopilot at this destination."

	computer_type = "syndishuttle"
	keyboard_type = "syndie_key"

	var/shuttle_number = 0

	var/obj/marker/shuttle_landing/linked_marker


/obj/structure/interactive/computer/console/shuttle_landing/Initialize()
	global_shuttle_number++
	shuttle_number = global_shuttle_number //Assign the shuttle landing number.
	all_shuttle_landing_consoles += src
	. = ..()



/obj/marker/landing_decal_left
	name = "landing decal 0"
	icon = 'icons/obj/decal/shuttle_number.dmi'
	icon_state = "0"
	alpha = 200
	initialize_type = INITIALIZE_LATE

	var/obj/structure/interactive/computer/console/shuttle_landing/linked_computer

/obj/marker/landing_decal_left/Finalize()

	. = ..()

	var/obj/structure/interactive/computer/console/shuttle_landing/best_computer
	var/best_distance = INFINITY
	for(var/k in all_shuttle_landing_consoles)
		var/obj/structure/interactive/computer/console/shuttle_landing/SL = k
		if(!best_computer)
			best_computer = SL
			best_distance = get_dist(SL,src)
			continue
		var/distance = get_dist(SL,src)
		if(distance > best_distance)
			continue
		best_distance = distance
		best_computer = SL

	var/obj/decal/shuttle_number/SN = new(src.loc)
	SN.icon_state = "[FLOOR(best_computer.shuttle_number/10,1)]"
	INITIALIZE(SN)
	GENERATE(SN)
	FINALIZE(SN)


/obj/marker/landing_decal_right
	name = "landing decal 1"
	icon = 'icons/obj/decal/shuttle_number.dmi'
	icon_state = "1"
	alpha = 200
	initialize_type = INITIALIZE_LATE

/obj/marker/landing_decal_right/Finalize()

	. = ..()

	var/obj/structure/interactive/computer/console/shuttle_landing/best_computer
	var/best_distance = INFINITY
	for(var/k in all_shuttle_landing_consoles)
		var/obj/structure/interactive/computer/console/shuttle_landing/SL = k
		if(!best_computer)
			best_computer = SL
			best_distance = get_dist(SL,src)
			continue
		var/distance = get_dist(SL,src)
		if(distance > best_distance)
			continue
		best_distance = distance
		best_computer = SL

	var/obj/decal/shuttle_number/SN = new(src.loc)
	SN.icon_state = "[best_computer.shuttle_number % 10]"
	INITIALIZE(SN)
	GENERATE(SN)
	FINALIZE(SN)



var/global/list/obj/marker/shuttle_landing/all_shuttle_landing_markers = list()

/obj/marker/shuttle_landing
	name = "landing zone"
	icon = 'icons/obj/markers/markers.dmi'
	icon_state = "spawn"
	initialize_type = INITIALIZE_NORMAL

	var/obj/structure/interactive/computer/console/shuttle_landing/linked_computer

	var/reserved = FALSE

/obj/marker/shuttle_landing/PostInitialize()
	. = ..()
	var/obj/structure/interactive/computer/console/shuttle_landing/best_computer
	var/best_distance = INFINITY
	for(var/k in all_shuttle_landing_consoles)
		var/obj/structure/interactive/computer/console/shuttle_landing/SL = k
		if(!best_computer)
			best_computer = SL
			best_distance = get_dist(SL,src)
			continue
		var/distance = get_dist(SL,src)
		if(distance > best_distance)
			continue
		best_distance = distance
		best_computer = SL

	if(best_computer)
		best_computer.linked_marker = src
		src.linked_computer = best_computer
		all_shuttle_landing_markers += src
	else
		qdel(src)
