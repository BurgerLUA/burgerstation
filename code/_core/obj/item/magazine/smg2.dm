/obj/item/magazine/smg_22
	name = "\improper .22 PDW magazine"
	bullet_type = ".22"
	icon = 'icons/obj/items/magazine/9mmsmg.dmi'
	icon_state = "9mmt"
	bullet_count_max = 20

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