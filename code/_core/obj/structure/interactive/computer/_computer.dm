obj/structure/interactive/computer
	name = "computer"
	desc = "Beep boop."
	desc_extended = "Operates things, depending on what the console is."
	icon = 'icons/obj/structure/computer.dmi'
	var/on = TRUE
	plane = PLANE_OBJ

obj/structure/interactive/computer/console
	name = "computer console"
	var/computer_type = "generic"
	var/keyboard_type = "generic_key"
	icon_state = "computer"

	desired_light_range = 1
	desired_light_power = 0.75
	desired_light_color = "#00FF00"

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	collision_dir = NORTH | EAST | SOUTH | WEST

	bullet_block_chance = 75

	density = TRUE

obj/structure/interactive/computer/console/PostInitialize()
	. = ..()
	update_sprite()
	return .

obj/structure/interactive/computer/console/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	var/icon/I = new/icon(icon,icon_state)

	if(computer_type && on)
		var/icon/I2 = new/icon(icon,computer_type)
		I.Blend(I2,ICON_OVERLAY)

	if(keyboard_type)
		var/icon/I3 = new/icon(icon,keyboard_type)
		I.Blend(I3,ICON_OVERLAY)

	icon = I

	return ..()

obj/structure/interactive/computer/console/laptop
	name = "personal laptop"
	icon_state = "laptop"


obj/structure/interactive/computer/console/old
	name = "old computer"
	desc = "An old, non-functional computer."
	desc_extended = "It doesn't even work. What gives?!"
	pixel_y = 10

	icon_state = "oldcomp"
	computer_type = "library"
	keyboard_type = "no_keyboard"


obj/structure/interactive/computer/console/old/chargen
	name = "\improper IMB piece of shit"

obj/structure/interactive/computer/console/old/chargen/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_player(caller))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	var/mob/living/advanced/player/P = caller
	P.dialogue_target_id = "chargen_computer"
	open_menu(P,/menu/dialogue/)

	return TRUE


obj/structure/interactive/computer/console/medical
	name = "medical console"
	computer_type = "medcomp"
	keyboard_type = "med_key"

obj/structure/interactive/computer/console/flight
	name = "flight control console"
	desc = "Beep boop."
	desc_extended = "Operates things, depending on what the console is. This one controls a shuttle."
	computer_type = "syndishuttle"
	keyboard_type = "syndie_key"

obj/structure/interactive/computer/console/flight/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT

	var/obj/shuttle_controller/SC = locate() in get_area(src)

	if(!SC)
		caller.to_chat(span("warning","No shuttle controller found!"))
		return FALSE

	if(SC.time_restricted && !SSgamemode.active_gamemode.allow_launch)
		caller.to_chat(span("warning","The shuttle isn't ready to launch yet!"))
		return FALSE

	var/selection = input("Are you sure you wish to launch this shuttle?","Shuttle Control","Cancel") in list("Yes","No","Cancel")

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	if(selection == "Yes")
		if(SC.state == SHUTTLE_STATE_LANDED)
			SC.state = SHUTTLE_STATE_WAITING
			SC.time = 0
			caller.to_chat(span("notice","You prepare the shuttle for launch."))
		else
			caller.to_chat(span("warning","ERROR: Shuttle already in transit."))

	return TRUE

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

obj/structure/interactive/computer/console/remote_flight/cargo
	name = "remote cargo shuttle console"
	desired_shuttle_controller = /obj/shuttle_controller/cargo

obj/structure/interactive/computer/console/old/station_job
	name = "job selection computer"
	computer_type = "library"
	keyboard_type = ""
	var/door_code = 0
	var/unit_number = 0

obj/structure/interactive/computer/console/old/station_job/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_player(caller))
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	var/mob/living/advanced/player/P = caller

	P.dialogue_target = src
	P.dialogue_target_id = "job_computer"
	open_menu(P,/menu/dialogue/)

	return TRUE

obj/structure/interactive/computer/console/remote_flight/alpha
	name = "remote alpha shuttle console"
	desired_shuttle_controller = /obj/shuttle_controller/alpha

obj/structure/interactive/computer/console/remote_flight/bravo
	name = "remote bravo shuttle console"
	desired_shuttle_controller = /obj/shuttle_controller/bravo

obj/structure/interactive/computer/console/remote_flight/charlie
	name = "remote charlie shuttle console"
	desired_shuttle_controller = /obj/shuttle_controller/charlie

obj/structure/interactive/computer/console/remote_flight/delta
	name = "remote delta shuttle console"
	desired_shuttle_controller = /obj/shuttle_controller/delta