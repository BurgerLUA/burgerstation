/obj/item/magazine/smg_46
	name = "\improper 4.6x30mm WT-550 magazine"
	icon = 'icons/obj/items/magazine/4mm_smg.dmi'
	icon_state = "mag"
	bullet_count_max = 20

	bullet_length_min = 12
	bullet_length_best = 17.7
	bullet_length_max = 19

	bullet_diameter_min = 5
	bullet_diameter_best = 5.6
	bullet_diameter_max = 6

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/pdw = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_4mm/

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/magazine/smg_46/update_icon()
	icon_state = "[initial(icon_state)]_[FLOOR((length(stored_bullets)/20)*5,1)]"
	..()

/*
/obj/item/magazine/smg_22/surplus
	name = "surplus .22 PDW magazine"
	ammo = /obj/item/bullet_cartridge/revolver_22/surplus

*/