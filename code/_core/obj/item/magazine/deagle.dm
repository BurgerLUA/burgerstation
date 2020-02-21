/obj/item/magazine/pistol_50
	name = "\improper .50 pistol magazine"
	bullet_type = ".50"
	icon = 'icons/obj/items/magazine/50aepistol.dmi'
	icon_state = "50aepistol"
	bullet_count_max = 7

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/deagle,
		/obj/item/weapon/ranged/bullet/magazine/pistol/deagle/gold
	)

	ammo = /obj/item/bullet/pistol_50

/obj/item/magazine/pistol_50/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()