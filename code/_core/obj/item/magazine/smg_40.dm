/obj/item/magazine/smg_40
	name = "\improper .40 smg magazine"
	icon = 'icons/obj/items/magazine/40smg.dmi'
	icon_state = "40"
	bullet_count_max = 36

	bullet_length_min = 21
	bullet_length_best = 22
	bullet_length_max = 23

	bullet_diameter_min = 9.8
	bullet_diameter_best = 10
	bullet_diameter_max = 11.2

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/nanotech = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_40

/obj/item/magazine/smg_40/update_icon()
	icon_state = "[initial(icon_state)]_[FLOOR((length(stored_bullets)/bullet_count_max)*12,1)]"
	return ..()