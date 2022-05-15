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

obj/structure/interactive/computer/console/Finalize()
	. = ..()
	update_sprite()

obj/structure/interactive/computer/console/update_icon()

	. = ..()

	if(computer_type && on)
		var/image/I2 = new/image(initial(icon),computer_type)
		I2.plane = PLANE_LIGHTING
		add_overlay(I2)


	if(keyboard_type)
		var/image/I3 = new/image(initial(icon),keyboard_type)
		I3.plane = PLANE_LIGHTING
		add_overlay(I3)

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

	if(!is_player(caller) || !caller.client)
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

obj/structure/interactive/computer/console/old/station_job
	name = "job selection computer"
	computer_type = "library"
	keyboard_type = ""
	var/door_code = 0
	var/unit_number = 0

obj/structure/interactive/computer/console/old/station_job/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_player(caller) || !caller.client)
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	var/mob/living/advanced/player/P = caller

	P.dialogue_target = src
	P.dialogue_target_id = "job_computer"
	open_menu(P,/menu/dialogue/)

	return TRUE