obj/structure/interactive/computer/wall
	name = "wall computer"
	desc = "Compute walls!"
	desc_extended = "It has no program and refuses to work."

	icon_state = "computer_wall"
	var/computer_type = "generic"
	var/keyboard_type = "generic_key"

obj/structure/interactive/computer/wall/Initialize()
	. = ..()
	setup_dir_offsets()
	dir = SOUTH

obj/structure/interactive/computer/wall/Finalize()
	. = ..()
	update_sprite()

obj/structure/interactive/computer/wall/update_overlays()

	. = ..()

	if(computer_type && on)
		var/image/I2 = new/image(initial(icon),computer_type)
		I2.plane = PLANE_LIGHTING
		add_overlay(I2)


	if(keyboard_type)
		var/image/I3 = new/image(initial(icon),keyboard_type)
		I3.plane = PLANE_LIGHTING
		add_overlay(I3)

obj/structure/interactive/computer/wall/dorms
	name = "dorms computer"
	desc = "Registration of dorms."
	desc_extended = "A computer intended to register dorms."

	desired_light_range = 1
	desired_light_power = 1
	desired_light_color = "#00FF00"



/obj/structure/interactive/computer/wall/remote_flight
	name = "remote flight computer"
	var/obj/shuttle_controller/desired_shuttle_controller

/obj/structure/interactive/computer/wall/remote_flight/Finalize()
	desired_shuttle_controller = locate(desired_shuttle_controller) in world
	return ..()

/obj/structure/interactive/computer/wall/remote_flight/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	if(desired_shuttle_controller.time_restricted && !SSgamemode.active_gamemode.allow_launch)
		activator.to_chat(span("warning","\The [desired_shuttle_controller.name] isn't ready to launch yet!"))
		return FALSE

	var/selection = input("Are you sure you wish to launch \the [desired_shuttle_controller.name]?","Shuttle Control","Cancel") as null|anything in list("Yes","No","Cancel")

	if(selection == "Yes")
		if(desired_shuttle_controller.state == SHUTTLE_STATE_LANDED)
			desired_shuttle_controller.state = SHUTTLE_STATE_WAITING
			desired_shuttle_controller.time = 0
			activator.visible_message(span("notice","\The [activator.name] prepares \the [src.name] for launch."),span("notice","You prepare \the [src.name] for launch."))
		else
			src.do_say("Warning: Shuttle already in transit.") //TODO: Make this more verbose.
	else
		activator.to_chat(span("notice","You decide not to launch \the [desired_shuttle_controller.name]."))

	return TRUE

/obj/structure/interactive/computer/wall/flight
	name = "flight control console"
	desc = "Beep boop."
	desc_extended = "Operates things, depending on what the console is. This one controls a shuttle."

/obj/structure/interactive/computer/wall/flight/clicked_on_by_object(var/mob/activator,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	var/obj/shuttle_controller/SC = locate() in get_area(src)

	if(!SC)
		activator.to_chat(span("warning","ERROR: No shuttle controller found!"))
		return FALSE

	if(SC.time_restricted && !SSgamemode.active_gamemode.allow_launch)
		activator.to_chat(span("warning","The shuttle isn't ready to launch yet!"))
		return FALSE

	var/selection = input("Are you sure you wish to launch this shuttle?","Shuttle Control","Cancel") in list("Yes","No","Cancel")

	if(selection == "Yes")
		if(SC.state == SHUTTLE_STATE_LANDED)
			SC.state = SHUTTLE_STATE_WAITING
			SC.time = 0
			activator.visible_message(span("notice","\The [activator.name] prepares \the [src.name] for launch."),span("notice","You prepare \the [src.name] for launch."))
		else
			src.do_say("Warning: Shuttle already in transit.") //TODO: Make this more verbose.
	else
		activator.to_chat(span("notice","You decide not to launch \the [SC.name]."))

	return TRUE