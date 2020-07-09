obj/item/ingot/
	name = "broken ingot"
	desc = "The ingot form of metal."
	desc_extended = "A metal ingot. Used for storage and other purposes."
	icon = 'icons/obj/items/ore.dmi'
	icon_state = "ingot_small"
	var/ingot_color = "#FFFFFF"


obj/item/ingot/New(var/desired_loc)
	..()
	update_icon()


obj/item/ingot/update_icon()

	icon_state = initial(icon_state)
	icon = initial(icon)

	var/icon/I = icon(icon,icon_state)
	I.Blend(ingot_color,ICON_MULTIPLY)

	icon = I

/obj/item/ingot/iron //Iron
	name = "iron ingot"
	ingot_color = COLOR_BLACK
	crafting_id = "ingot_iron"

/obj/item/ingot/steel //Iron + Carbon
	name = "steel ingot"
	ingot_color = COLOR_STEEL
	crafting_id = "ingot_steel"

/obj/item/ingot/plastisteel //Plasma + Steel
	name = "plastisteel ingot"
	ingot_color = "#A088A0"
	crafting_id = "ingot_plastisteel"

/obj/item/ingot/gullium //Plasma + Gold
	name = "gullium ingot"
	ingot_color = "#B288A7"
	crafting_id = "ingot_gullium"

/obj/item/ingot/replium //Plasma + Silver
	name = "replium ingot"
	ingot_color = "#DBBADB"
	crafting_id = "ingot_replium"