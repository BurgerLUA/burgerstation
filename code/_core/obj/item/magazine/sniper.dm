/obj/item/magazine/sniper_50
	name = "\improper .50 magazine"
	bullet_type = ".50"
	icon = 'icons/obj/items/magazine/50.dmi'
	icon_state = "50"
	bullet_count_max = 4

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/heavy_sniper
	)

	ammo = /obj/item/bullet/sniper_50

/obj/item/magazine/sniper_50/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()

/obj/item/magazine/sniper_50/surplus
	name = "\improper surplus .50 magazine"
	ammo = /obj/item/bullet/sniper_50/surplus
