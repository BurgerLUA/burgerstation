/obj/item/magazine/pistol_8mm
	name = "\improper 8mm pistol magazine"
	bullet_type = "8"
	icon = 'icons/obj/items/magazine/8mmpistol.dmi'
	icon_state = "8mm"
	bullet_count_max = 4

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/silenced
	)

	ammo = /obj/item/bullet/pistol_8mm

/obj/item/magazine/pistol_8mm/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_[length(stored_bullets)]"
	else
		icon_state = "[initial(icon_state)]_0"

	..()
/*
/obj/item/magazine/pistol_8mm/hollowpoint
	name = "\improper 8mm hollow point pistol magazine"
	ammo = /obj/item/bullet/pistol_8mm/hollowpoint
*/