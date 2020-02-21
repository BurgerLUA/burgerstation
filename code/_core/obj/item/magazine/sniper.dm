/obj/item/magazine/sniper_762
	name = "\improper 7.62mm sniper magazine"
	bullet_type = "7.62"
	icon = 'icons/obj/items/magazine/762_sniper.dmi'
	icon_state = "762"
	bullet_count_max = 10

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper
	)

	ammo = /obj/item/bullet_cartridge/sniper_762

/obj/item/magazine/sniper_762/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()

/obj/item/magazine/sniper_50
	name = "\improper .50 sniper magazine"
	bullet_type = ".50"
	icon = 'icons/obj/items/magazine/50_sniper.dmi'
	icon_state = "50"
	bullet_count_max = 4

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper
	)

	ammo = /obj/item/bullet_cartridge/sniper_50

/obj/item/magazine/sniper_50/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()
