obj/structure/interactive/computer
	name = "computer"
	desc = "Beep boop."
	icon = 'icons/obj/structure/computer.dmi'
	var/on = TRUE

obj/structure/interactive/computer/console
	name = "computer console"
	var/computer_type = "generic"
	var/keyboard_type = "generic_key"
	icon_state = "computer"

	desired_light_range = 1
	desired_light_power = 0.75
	desired_light_color = "#00FF00"

obj/structure/interactive/computer/console/Initialize()
	. = ..()
	update_icon()
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
	icon_state = "oldcomp"
	pixel_y = 10


obj/structure/interactive/computer/console/old/chargen
	name = "\improper IMB piece of shit"
	computer_type = "library"
	keyboard_type = ""

obj/structure/interactive/computer/console/old/chargen/clicked_on_by_object(caller,object,location,control,params)

	if(!is_player(caller))
		return TRUE

	INTERACT_CHECK

	var/mob/living/advanced/player/P = caller

	P.dialogue_target_id = "chargen_computer"
	open_menu(P,"dialogue")

	return TRUE


obj/structure/interactive/computer/console/medical
	name = "medical console"
	computer_type = "medcomp"
	keyboard_type = "med_key"

obj/structure/interactive/computer/console/flight
	name = "flight control console"
	computer_type = "syndishuttle"
	keyboard_type = "syndie_key"

obj/structure/interactive/computer/console/flight/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	var/selection = input("Are you sure you wish to launch this shuttle?","Shuttle Control","Cancel") in list("Yes","No","Cancel")

	if(selection == "Yes")
		var/obj/shuttle_controller/SC = locate() in get_area(src)
		if(SC)
			if(SC.state == SHUTTLE_STATE_LANDED)
				SC.state = SHUTTLE_STATE_WAITING
				SC.time = 0
				caller.to_chat("You prepare the shuttle for launch.")
			else
				caller.to_chat("ERROR: Shuttle already in transit.")
		else
			caller.to_chat("ERROR: No shuttle controller found!")

	return TRUE

obj/structure/interactive/computer/console/remote_flight
	name = "remote flight control console"
	computer_type = "syndishuttle"
	keyboard_type = "syndie_key"

	var/obj/shuttle_controller/desired_shuttle_controller

obj/structure/interactive/computer/console/remote_flight/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_advanced(caller))
		return ..()

	var/selection = input("Are you sure you wish to launch this shuttle?","Shuttle Control","Cancel") in list("Yes","No","Cancel")

	if(selection == "Yes")
		var/obj/shuttle_controller/SC = locate(desired_shuttle_controller) in world
		if(SC)
			if(SC.state == SHUTTLE_STATE_LANDED)
				SC.state = SHUTTLE_STATE_WAITING
				SC.time = 0
				caller.to_chat("You prepare the shuttle for launch.")
			else
				caller.to_chat("ERROR: Shuttle already in transit.")
		else
			caller.to_chat("ERROR: No shuttle controller found!")

obj/structure/interactive/computer/console/remote_flight/cargo
	name = "remote cargo shuttle console"
	desired_shuttle_controller = /obj/shuttle_controller/cargo

obj/structure/interactive/computer/console/old/station_job
	name = "job selection computer"
	computer_type = "library"
	keyboard_type = ""
	var/door_code = 0
	var/unit_number = 0

obj/structure/interactive/computer/console/old/station_job/clicked_on_by_object(caller,object,location,control,params)

	if(!is_player(caller))
		return TRUE

	INTERACT_CHECK

	var/mob/living/advanced/player/P = caller

	P.dialogue_target = src
	P.dialogue_target_id = "job_computer"
	open_menu(P,"dialogue")

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