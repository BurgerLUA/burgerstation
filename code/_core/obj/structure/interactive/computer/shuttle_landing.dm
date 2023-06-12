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

/obj/structure/interactive/computer/console/shuttle_landing/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	var/mob/living/L = caller

	if(!linked_marker)
		return ..()

	INTERACT_CHECK

	if(linked_marker.reserved_by_shuttle)
		L.to_chat(span("notice","\The [src.name] reports that a shuttle is already inbound or has already landed in this area."))
		return TRUE

	if(!SSgamemode.active_gamemode?.allow_launch)
		L.to_chat(span("warning","Error: Shuttles are not ready to launch yet."))
		return TRUE

	while(TRUE)
		var/list/choices = list("Cancel" = "Cancel")

		if(linked_marker.owning_shuttle)
			var/obj/shuttle_controller/SC = linked_marker.owning_shuttle
			if(SC.loyalty_owner != L.loyalty_tag)
				continue
			var/area/A = get_area(SC)
			var/shuttle_text = "[A.name]: [SC.state]"
			choices[shuttle_text] = SC
		else
			for(var/k in all_shuttle_controlers)
				var/obj/shuttle_controller/SC = k
				if(SC.loyalty_owner != L.loyalty_tag)
					continue
				var/area/A = get_area(SC)
				var/shuttle_text = "[A.name]: [SC.state]"
				choices[shuttle_text] = SC

		var/desired_choice = input("Select a shuttle to call.","Shuttle calling","Cancel") as null|anything in choices

		INTERACT_CHECK

		if(!desired_choice || desired_choice == "Cancel")
			return TRUE

		if(!SSgamemode.active_gamemode.allow_launch)
			L.to_chat(span("warning","Error: Shuttles are not ready to launch yet."))
			return TRUE

		var/obj/shuttle_controller/SC = choices[desired_choice]
		if(SC.state != SHUTTLE_STATE_LANDED)
			caller.to_chat(span("notice","That shuttle is currently [SC.state]."))
			continue

		if(linked_marker.reserved_by_shuttle)
			L.to_chat(span("notice","\The [src.name] reports that a shuttle is already inbound or has already landed in this area."))
			return TRUE

		desired_choice = input("Are you sure you wish to call this shuttle?","Call shuttle","Cancel") as null|anything in list("Yes","No","Cancel")

		INTERACT_CHECK

		if(!desired_choice || desired_choice == "Cancel")
			return TRUE

		if(desired_choice == "No")
			continue

		//Only choice: Yes.

		if(SC.set_destination(caller,linked_marker) && SC.start_flight(caller))
			return TRUE

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

	var/reserved_by_shuttle = FALSE

	var/obj/shuttle_controller/owning_shuttle //Who owns the marker? Applies to bluespace transit areas and base transit areas.

	anchored = 2

/obj/marker/shuttle_landing/proc/set_reserved(var/desired_reserved=TRUE)

	if(reserved_by_shuttle == desired_reserved)
		CRASH("Tried setting [src.get_debug_name()] reserved var to [desired_reserved], but it was already [desired_reserved]!")
		return FALSE

	src.reserved_by_shuttle = desired_reserved

	return TRUE

/obj/marker/shuttle_landing/Finalize()
	. = ..()
	if(!SSdmm_suite.is_pvp_coord(loc.x,loc.y,loc.z,32))
		var/obj/structure/interactive/computer/console/shuttle_landing/best_computer
		var/best_distance = 1 + VIEW_RANGE*2
		for(var/k in all_shuttle_landing_consoles)
			var/obj/structure/interactive/computer/console/shuttle_landing/SL = k
			if(SL.z != src.z)
				continue
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

		if(!owning_shuttle)
			all_shuttle_landing_markers += src
