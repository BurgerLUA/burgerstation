obj/structure/interactive/cryopod
	name = "cryopod"
	desc = "What the hell is in there?"
	icon = 'icons/obj/structure/cryo.dmi'
	icon_state = "cell_off"

	desired_light_power = 0.1
	desired_light_range = 2
	desired_light_color = "#3ADD7C"

	plane = PLANE_OBJ

	bullet_block_chance = 90



obj/structure/interactive/cryopod/occupied
	icon_state = "cell_occupied"

	desired_light_power = 0.5
	desired_light_range = 4
	desired_light_color = "#3AFF3A"

