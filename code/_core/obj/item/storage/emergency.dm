/obj/item/storage/emergency
	name = "survival kit"
	icon = 'icons/obj/item/storage/boxes.dmi'
	icon_state = "emergency"


/obj/item/storage/emergency/fill_inventory()
	new /obj/item/container/medicine/bandage(src)
	new /obj/item/container/medicine/ointment(src)
	new /obj/item/container/pill/dylovene(src)
	new /obj/item/container/syringe/epinephrine(src)
	return ..()
