/obj/item/magazine/lmg_223
	name = "\improper .223 lmg magazine"
	bullet_type = ".223"
	icon = 'icons/obj/items/magazine/223_lmg.dmi'
	icon_state = "223"
	bullet_count_max = 60

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/lmg
	)

	ammo = /obj/item/bullet/rifle_223

	size = SIZE_3
	weight = WEIGHT_3

/obj/item/magazine/lmg_223/update_icon()
	var/math_mod = (length(stored_bullets) / bullet_count_max) * 11
	icon_state = "[initial(icon_state)]_[ceiling(math_mod)]"
	..()

/obj/item/magazine/lmg_223/surplus
	name = "\improper surplus .223 lmg magazine"
	ammo = /obj/item/bullet/rifle_223/surplus
