/obj/item/magazine/lmg_556
	name = "\improper 5.56 lmg magazine"
	icon = 'icons/obj/items/magazine/223_lmg.dmi'
	icon_state = "223"
	bullet_count_max = 60

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg
	)

	ammo = /obj/item/bullet_cartridge/rifle_223/syndicate

	size = SIZE_3
	weight = WEIGHT_3

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

/obj/item/magazine/lmg_556/update_icon()
	var/math_mod = (length(stored_bullets) / bullet_count_max) * 11
	icon_state = "[initial(icon_state)]_[CEILING(math_mod, 1)]"
	..()