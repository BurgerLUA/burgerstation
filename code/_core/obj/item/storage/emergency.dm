/obj/item/storage/emergency
	name = "survival kit"
	desc = "Where are your internals man"
	desc_extended = "A very small box that starts with some basic medical supplies. Could save someone's life in a pinch."
	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "emergency"


/obj/item/storage/emergency/fill_inventory()
	new /obj/item/container/healing/bandage(src)
	new /obj/item/container/healing/ointment(src)
	new /obj/item/container/edible/pill/dylovene(src)
	new /obj/item/container/syringe/hypodermic/epinephrine(src)
	. = ..()
