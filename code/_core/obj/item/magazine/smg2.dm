/obj/item/magazine/smg_9mm
	name = "\improper 9mm PDW magazine"
	bullet_type = "9mm"
	icon = 'icons/obj/items/magazine/9mmsmg.dmi'
	icon_state = "9mmt"
	bullet_count_max = 20

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/pdw
	)

	ammo = /obj/item/bullet/pistol_9mm

/obj/item/magazine/smg_9mm/update_icon()
	icon_state = "[initial(icon_state)]-[round(length(stored_bullets),4)]"
	..()

/obj/item/magazine/smg_9mm/surplus
	name = "surplus 9mm PDW magazine"
	ammo = /obj/item/bullet/pistol_9mm/surplus

