/obj/item/weapon_part/
	name = "weapon part"
	icon = 'icons/obj/items/weapons/melee/material.dmi'
	//icon_state = "binding"
	var/material_id = null
	var/material_color = "#FFFFFF"

/obj/item/weapon_part/New(var/desired_loc)
	..()
	update_icon()

/obj/item/weapon_part/update_icon()

	icon_state = initial(icon_state)
	icon = initial(icon)

	var/icon/I = icon(icon,icon_state)
	I.Blend(material_color,ICON_MULTIPLY)

	icon = I

/obj/item/weapon_part/blade/long
	icon_state = "blade_long"

/obj/item/weapon_part/binding
	icon_state = "binding"

/obj/item/weapon_part/handle/sword/
	icon_state = "sword_handle_small"
