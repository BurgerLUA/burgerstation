/obj/item/magazine/shotgun_auto
	name = "\improper 12 gauge AS-12 magazine"
	icon = 'icons/obj/items/magazine/auto_shotgun.dmi'
	icon_state = "auto"
	bullet_count_max = 9

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/shotgun/bull = TRUE
	)

	ammo = /obj/item/bullet_cartridge/shotgun/slug

	bullet_length_min = 18
	bullet_length_best = 18.5
	bullet_length_max = 19

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19

/obj/item/magazine/shotgun_auto/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets)]"
	return ..()