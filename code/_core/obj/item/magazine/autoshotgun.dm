/obj/item/magazine/shotgun_auto
	name = "\improper 12 gauge AS-12 magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains slug shells for a magazine-fed bullpup shotgun. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/auto_shotgun.dmi'
	icon_state = "auto"
	bullet_count_max = 9

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/shotgun/bull = TRUE
	)

	ammo = /obj/item/bullet_cartridge/shotgun_12/slug

	bullet_length_min = 18
	bullet_length_best = 18.5
	bullet_length_max = 19

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19


	size = SIZE_2
	weight = WEIGHT_3

/obj/item/magazine/shotgun_auto/buckshot
	name = "\improper 12 gauge AS-12 magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains buckshot shells for a magazine-fed bullpup shotgun. Make sure you're trying to use the right caliber."

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/shotgun/bull = TRUE
	)

	ammo = /obj/item/bullet_cartridge/shotgun_12/buckshot

/obj/item/magazine/shotgun_auto/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets)]"
	return ..()


/obj/item/magazine/shotgun_auto/empty
	ammo = null