/obj/item/magazine/rifle_556
	name = "\improper 5.56 rifle magazine"
	icon = 'icons/obj/items/magazine/556_rifle.dmi'
	icon_state = "556"
	bullet_count_max = 20

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/nt_carbine = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/standard = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/civ_carbine = TRUE

	)

	ammo = /obj/item/bullet_cartridge/rifle_223

	size = SIZE_2
	weight = WEIGHT_2

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

/obj/item/magazine/rifle_556/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets) ? 1 : 0]"
	return ..()