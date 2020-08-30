/obj/item/magazine/smg_45
	name = "\improper .45 smg magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/45smg.dmi'
	icon_state = "mag"
	bullet_count_max = 36

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/bullpup = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/standard = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_45

	size = SIZE_2


/obj/item/magazine/smg_45/update_icon()
	icon_state = "[initial(icon_state)]_[FLOOR((length(stored_bullets)/bullet_count_max)*10,1)]"
	..()

/*
/obj/item/magazine/smg_45/surplus
	name = "\improper surplus .45 smg magazine"

	ammo = /obj/item/bullet_cartridge/pistol_45/surplus
*/


/*
/obj/item/magazine/smg_22/
	name = "\improper .22 smg magazine"
	bullet_type = ".22"
	icon = 'icons/obj/item/magazine/22smg.dmi'
	icon_state = "22"
	bullet_count_max = 28

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/wasp
	)

	ammo = /obj/item/bullet_cartridge/pistol_22

	bullet_length_min = 12
	bullet_length_best = 17.7
	bullet_length_max = 19

	bullet_diameter_min = 5
	bullet_diameter_best = 5.6
	bullet_diameter_max = 6

/obj/item/magazine/smg_22/update_icon()
	icon_state = "[initial(icon_state)]-[CEILING(length(stored_bullets),2)]"
	..()
*/

/*
/obj/item/magazine/smg_22/surplus
	name = "\improper surplus .22 smg magazine"
	ammo = /obj/item/bullet_cartridge/revolver_22/surplus
*/