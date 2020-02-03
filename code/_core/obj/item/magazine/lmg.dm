/obj/item/magazine/lmg_556
	name = "\improper 5.56 lmg magazine"
	bullet_type = "5.56"
	icon = 'icons/obj/items/magazine/223_lmg.dmi'
	icon_state = "556"
	bullet_count_max = 60

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/lmg
	)

	ammo = /obj/item/bullet/rifle_223/syndicate

	size = SIZE_3
	weight = WEIGHT_3

/obj/item/magazine/lmg_556/update_icon()
	var/math_mod = (length(stored_bullets) / bullet_count_max) * 11
	icon_state = "[initial(icon_state)]_[ceiling(math_mod)]"
	..()