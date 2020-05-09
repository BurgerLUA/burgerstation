/obj/item/magazine/smg_22
	name = "\improper .22 PDW magazine"
	icon = 'icons/obj/items/magazine/9mmsmg.dmi'
	icon_state = "9mmt"
	bullet_count_max = 20

	bullet_length_min = 12
	bullet_length_best = 17.7
	bullet_length_max = 19

	bullet_diameter_min = 5
	bullet_diameter_best = 5.6
	bullet_diameter_max = 6

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/pdw
	)

	ammo = /obj/item/bullet_cartridge/pistol_22

/obj/item/magazine/smg_22/update_icon()
	icon_state = "[initial(icon_state)]-[round(length(stored_bullets),4)]"
	..()

/*
/obj/item/magazine/smg_22/surplus
	name = "surplus .22 PDW magazine"
	ammo = /obj/item/bullet_cartridge/revolver_22/surplus

*/