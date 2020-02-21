/obj/item/magazine/smg_45
	name = "\improper .45 smg magazine"
	icon = 'icons/obj/items/magazine/45smg.dmi'
	icon_state = "c20r45"
	bullet_count_max = 24

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg
	)

	ammo = /obj/item/bullet_cartridge/pistol_45

/obj/item/magazine/smg_45/update_icon()
	icon_state = "[initial(icon_state)]-[round(length(stored_bullets),2)]"
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
	icon = 'icons/obj/items/magazine/22smg.dmi'
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
	icon_state = "[initial(icon_state)]-[ceiling(length(stored_bullets),2)]"
	..()
*/

/*
/obj/item/magazine/smg_22/surplus
	name = "\improper surplus .22 smg magazine"
	ammo = /obj/item/bullet_cartridge/revolver_22/surplus
*/