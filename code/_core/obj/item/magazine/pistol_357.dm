/obj/item/magazine/pistol_357
	name = "\improper .357 pistol magazine"
	bullet_type = ".357"
	icon = 'icons/obj/items/magazine/357pistol.dmi'
	icon_state = "357"
	bullet_count_max = 7

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/mercenary
	)

	ammo = /obj/item/bullet/revolver_357

/obj/item/magazine/pistol_357/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()