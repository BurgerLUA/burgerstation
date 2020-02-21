/obj/item/magazine/carbine_556
	name = "\improper 5.56 carbine magazine"
	icon = 'icons/obj/items/magazine/556_carbine.dmi'
	icon_state = "556"
	bullet_count_max = 21

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/carbine
	)

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ammo = /obj/item/bullet/rifle_223

/obj/item/magazine/carbine_556/update_icon()
	icon_state = "[initial(icon_state)]_[round(length(stored_bullets))]"
	..()