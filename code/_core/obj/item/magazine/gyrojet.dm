/obj/item/magazine/gyrojet
	name = "\improper 20mm gyrojet magazine"
	bullet_type = "gyrojet"
	icon = 'icons/obj/items/magazine/gyrojet.dmi'
	icon_state = "gyrojet"
	bullet_count_max = 4

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/gyrojet
	)

	ammo = /obj/item/bullet/gyrojet

/obj/item/magazine/gyrojet/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()