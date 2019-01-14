obj/item/holder/
	icon = 'icons/hud/inventory.dmi'
	icon_state = "wielded"

	var/obj/item/weapon/connected_weapon

obj/item/holder/New(var/loc,var/obj/item/weapon/weapon_to_own)
	connected_weapon = weapon_to_own
	..()

obj/item/holder/update_icon()
	var/icon/I = icon(icon,icon_state = icon_state)
	I.Blend(rgb(255,0,0),BLEND_OVERLAY)
	icon = I
	..()

/obj/item/holder/defer_click_on_object()
	return connected_weapon

/obj/item/holder/on_pickup(var/obj/inventory/I)
	return

/obj/item/holder/on_drop(var/obj/inventory/I)
	if(is_inventory(connected_weapon.loc))
		var/obj/inventory/I2 = connected_weapon.loc
		I2.drop_item(connected_weapon)