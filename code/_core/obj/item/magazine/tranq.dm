/obj/item/magazine/pistol_tranq_11m
	name = "\improper 11.43x25mm tranquilizer magazine"
	icon = 'icons/obj/item/magazine/tranq.dmi'
	icon_state = "tranq"
	bullet_count_max = 7

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/tranq = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/tranq_11m

	bullet_length_min = 23
	bullet_length_best = 25
	bullet_length_max = 26

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/magazine/pistol_tranq_11m/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets)]"
	return ..()
