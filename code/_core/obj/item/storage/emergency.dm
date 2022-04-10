/obj/item/storage/emergency
	name = "survival kit"
	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "emergency"


/obj/item/storage/emergency/fill_inventory()
	new /obj/item/container/healing/bandage(src)
	new /obj/item/container/healing/ointment(src)
	new /obj/item/container/edible/pill/dylovene(src)
	new /obj/item/container/syringe/hypodermic/epinephrine(src)
	. = ..()
