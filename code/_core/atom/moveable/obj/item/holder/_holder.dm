/*
obj/holder/
	icon = null
	icon_state = null

	var/obj/item/weapon/connected_weapon

obj/holder/New(var/loc,var/obj/item/weapon/weapon_to_own)
	connected_weapon = weapon_to_own
	..()

obj/holder/defer_click_on_object()
	return connected_weapon
*/

/*
/obj/holder/on_pickup(var/obj/inventory/I)
	return

/obj/holder/on_drop(var/obj/inventory/I)
	if(is_inventory(connected_weapon.loc))
		var/obj/inventory/I2 = connected_weapon.loc
		I2.drop_item(connected_weapon)
*/
