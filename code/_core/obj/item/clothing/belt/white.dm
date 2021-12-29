/obj/item/clothing/belt/storage/colored
	name = "storage belt"
	icon = 'icons/obj/item/clothing/belts/white.dmi'
	desc = "Don't make me get the belt."
	desc_extended = "Stores a robust amount of items that can easily and quickly be accessed."
	dyeable = TRUE

/obj/item/clothing/belt/storage/colored/black
	color = COLOR_BLACK

/obj/item/clothing/belt/storage/colored/grey
	color = COLOR_GREY

/obj/item/clothing/belt/storage/colored/gold
	color = COLOR_GOLD

/obj/item/clothing/belt/storage/colored/brown
	color = COLOR_BROWN

/obj/item/clothing/belt/storage/colored/orange
	color = COLOR_ORANGE

/obj/item/clothing/belt/storage/colored/chemistry
	color = COLOR_CHEMISTRY

/obj/item/clothing/belt/storage/colored/janitor
	color = COLOR_JANITOR

/obj/item/clothing/belt/storage/colored/purple
	color = COLOR_PURPLE

/obj/item/clothing/belt/storage/colored/merc
	color = "#4C5E56"

/obj/item/clothing/belt/storage/colored/merc_alt
	color = "#97805C"

/obj/item/clothing/belt/storage/colored/recruit
	color = COLOR_RECRUIT_DARK
	value_burgerbux = 1

/obj/item/clothing/belt/storage/colored/recruit/fill_inventory()
	for(var/i=1,i<=dynamic_inventory_count-1,i++)
		new /obj/item/magazine/rifle_46(src)
	new /obj/item/weapon/melee/energy/grazer(src)
	. = ..()