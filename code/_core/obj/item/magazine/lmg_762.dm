/obj/item/magazine/lmg_762
	name = "\improper 12 gauge AS-12 magazine"
	icon = 'icons/obj/items/magazine/auto_shotgun.dmi'
	icon_state = "auto"
	bullet_count_max = 9

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/nt_lmg = TRUE
	)

	ammo = /obj/item/bullet_cartridge/rifle_308

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

/obj/item/magazine/lmg_762/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets) ? 1 : 0]"
	return ..()