/obj/item/magazine/syringe_gun
	name = "\improper syringe gun magazine"
	icon = 'icons/obj/items/magazine/syringegun.dmi'
	icon_state = "syringe"
	bullet_count_max = 8

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/syringe = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/syringe_gun/

	bullet_length_min = 18.5
	bullet_length_best = 18.5
	bullet_length_max = 18.5

	bullet_diameter_min = 18.5
	bullet_diameter_best = 18.5
	bullet_diameter_max = 18.5

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/magazine/syringe_gun/update_icon()
	icon_state = "[length(stored_bullets)]"
	..()