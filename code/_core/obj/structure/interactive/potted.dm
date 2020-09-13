obj/structure/interactive/potted_plant
	name = "potted plant"
	desc = "For replacing the oxygen that theese retards waste."
	desc_extended = "A randomized potted plant as decor to liven up the area."
	icon = 'icons/obj/structure/flora/potted.dmi'

	bullet_block_chance = 25

	pixel_y = 8

	plane = PLANE_SCENERY

obj/structure/interactive/potted_plant/nanotrasen
	icon_state = "nt_1"

obj/structure/interactive/potted_plant/nanotrasen/New(var/desired_loc)
	icon_state = "nt_[rand(1,6)]"
	return ..()

obj/structure/interactive/potted_plant/office
	icon_state = "office_1"

obj/structure/interactive/potted_plant/office/New(var/desired_loc)
	icon_state = "office_[rand(1,3)]"
	return ..()

obj/structure/interactive/potted_plant/bin
	icon_state = "bin_1"

obj/structure/interactive/potted_plant/bin/New(var/desired_loc)
	icon_state = "bin_[rand(1,4)]"
	return ..()