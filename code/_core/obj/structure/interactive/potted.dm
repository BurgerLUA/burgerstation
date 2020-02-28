obj/structure/interactive/potted_plant
	name = "potted plant"
	icon = 'icons/obj/structure/flora/potted.dmi'

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