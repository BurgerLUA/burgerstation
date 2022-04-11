var/global/list/obj/structure/interactive/computer/console/remote_flight/all_remote_flight_consoles = list()

/obj/structure/interactive/computer/console/remote_flight
	name = "remote flight control console"
	computer_type = "syndishuttle"
	keyboard_type = "syndie_key"

	var/obj/shuttle_controller/desired_shuttle_controller

/obj/structure/interactive/computer/console/remote_flight/Finalize()
	desired_shuttle_controller = locate(desired_shuttle_controller) in world
	all_remote_flight_consoles += src
	return ..()

/obj/structure/interactive/computer/console/remote_flight/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT

	if(!SSgamemode.active_gamemode.allow_launch)
		caller.to_chat(span("warning","\The [desired_shuttle_controller.name] isn't ready to launch yet!"))
		return FALSE

	var/selection = input("Are you sure you wish to launch \the [desired_shuttle_controller.name]?","Shuttle Control","Cancel") as null|anything in list("Yes","No","Cancel")

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	if(selection == "Yes")
		if(desired_shuttle_controller.state == SHUTTLE_STATE_LANDED)
			desired_shuttle_controller.state = SHUTTLE_STATE_WAITING
			desired_shuttle_controller.time = 0
			caller.visible_message(span("notice","\The [caller.name] prepares \the [src.name] for launch."),span("notice","You prepare \the [src.name] for launch."))
		else
			caller.to_chat(span("warning","ERROR: \The [desired_shuttle_controller.name] is already in transit."))
	else
		caller.to_chat(span("notice","You decide not to launch \the [desired_shuttle_controller.name]."))

	return TRUE