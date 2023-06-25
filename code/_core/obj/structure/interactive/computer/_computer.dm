obj/structure/interactive/computer
	name = "computer"
	desc = "Beep boop."
	desc_extended = "Operates things, depending on what the console is."
	icon = 'icons/obj/structure/computer.dmi'
	var/on = TRUE
	plane = PLANE_MOVABLE

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

obj/structure/interactive/computer/console/update_overlays()

	. = ..()

	if(computer_type && on)
		var/image/I = new/image(initial(icon),computer_type)
		I.appearance_flags = src.appearance_flags | KEEP_APART | RESET_COLOR
		I.plane = PLANE_LIGHTING_EFFECT
		add_overlay(I)

	if(keyboard_type)
		var/image/I = new/image(initial(icon),keyboard_type)
		I.appearance_flags = src.appearance_flags | KEEP_APART | RESET_COLOR
		I.plane = PLANE_LIGHTING_EFFECT
		add_overlay(I)

obj/structure/interactive/computer/console/laptop
	name = "personal laptop"
	icon_state = "laptop"


obj/structure/interactive/computer/console/old
	name = "old computer"
	desc = "It doesn't even work. What gives?!"
	desc_extended = "An old, non-functional computer."
	pixel_y = 10

	icon_state = "oldcomp"
	computer_type = "library"
	keyboard_type = "no_keyboard"


obj/structure/interactive/computer/console/old/cargo/
	name = "old cargo computer"
	desc = "At least it works."
	desc_extended = "An old computer meant to handle cargo orders."

obj/structure/interactive/computer/console/old/cargo/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_player(caller) || !caller.client)
		return ..()

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(5)

	var/mob/living/advanced/player/P = caller

	P.dialogue_target = src
	P.dialogue_target_id = /dialogue/npc/cargo_computer/
	open_menu(P,/menu/dialogue/)

	return TRUE




obj/structure/interactive/computer/console/medical
	name = "medical console"
	computer_type = "medcomp"
	keyboard_type = "med_key"

obj/structure/interactive/computer/console/old/cargo
	name = "cargo computer"
	computer_type = "library"
	keyboard_type = ""

obj/structure/interactive/computer/console/engineering
	name = "engineering console"

obj/structure/interactive/computer/console/engineering/Generate()
	computer_type = pick("power","solar","tank","area_atmos","alert:1")
	keyboard_type = "[computer_type]_key"

	var/list/type_to_light = list(
		"power" = "#C6B227",
		"solar" = "#C6B227",
		"tank" = "#BFE2FF",
		"area_atmos" = "#BFE2FF",
		"alert:1" = "#BFE2FF",
	)

	desired_light_color = type_to_light[computer_type]

	. = ..()