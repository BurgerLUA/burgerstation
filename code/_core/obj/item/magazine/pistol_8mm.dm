/obj/item/magazine/pistol_8mm
	name = "\improper 8mm pistol magazine"
	bullet_type = "8mm"
	icon = 'icons/obj/items/magazine/8mmpistol.dmi'
	icon_state = "8mm"
	bullet_count_max = 15

	weapon_whitelist = list(

	)

	ammo = /obj/item/bullet/pistol_8mm

/obj/item/magazine/pistol_8mm/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()