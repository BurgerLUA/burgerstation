/obj/item/clothing/belt/storage/colored
	name = "storage belt"
	icon = 'icons/obj/items/clothing/belts/white.dmi'
	desc = "Don't make me get the belt."
	desc_extended = "Stores a robust amount of items that can easily and quickly be accessed."

/obj/item/clothing/belt/storage/colored/black
	color = COLOR_BLACK


/obj/item/clothing/belt/storage/colored/black/filled/fill_inventory()
	new /obj/item/weapon/ranged/bullet/magazine/pistol/secpistol/special(src)
	new /obj/item/magazine/pistol_45(src)
	new /obj/item/magazine/pistol_45(src)
	new /obj/item/magazine/pistol_45(src)
	new /obj/item/weapon/melee/energy/stunbaton(src)
	new /obj/item/weapon/melee/energy/shield(src)
	new /obj/item/container/medicine/bandage(src)
	new /obj/item/container/medicine/ointment(src)
	return ..()