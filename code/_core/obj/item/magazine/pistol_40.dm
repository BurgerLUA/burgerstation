/obj/item/magazine/pistol_40
	name = "\improper .40 pistol magazine"
	icon = 'icons/obj/items/magazine/40pistol.dmi'
	icon_state = "40"
	bullet_count_max = 9

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/military = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/military/mod = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_40

	bullet_length_min = 21
	bullet_length_best = 22
	bullet_length_max = 23

	bullet_diameter_min = 9.8
	bullet_diameter_best = 10
	bullet_diameter_max = 11.2

/obj/item/magazine/pistol_40/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets)]"
	return ..()
