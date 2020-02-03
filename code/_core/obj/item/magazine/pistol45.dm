/obj/item/magazine/pistol_45
	name = "\improper .45 pistol magazine"
	bullet_type = ".45"
	icon = 'icons/obj/items/magazine/45pistol.dmi'
	icon_state = "45"
	bullet_count_max = 7

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/tactical,
		/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/mod,
		/obj/item/weapon/ranged/bullet/magazine/pistol/military,
		/obj/item/weapon/ranged/bullet/magazine/pistol/military/mod
	)

	ammo = /obj/item/bullet/pistol_45

/obj/item/magazine/pistol_45/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets)]"
	..()


/obj/item/magazine/pistol_45/surplus
	name = "\improper surplus .45 pistol magazine"

	ammo = /obj/item/bullet/pistol_45/surplus

/obj/item/magazine/pistol_45/rubber
	name = "\improper rubber .45 pistol magazine"

	ammo = /obj/item/bullet/pistol_45/rubber