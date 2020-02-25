/obj/item/magazine/sniper_762
	name = "\improper 7.62mm sniper magazine"
	icon = 'icons/obj/items/magazine/762_sniper.dmi'
	icon_state = "762"
	bullet_count_max = 10

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper
	)

	ammo = /obj/item/bullet_cartridge/rifle_308/syndicate

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

/obj/item/magazine/sniper_762/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()

/obj/item/magazine/sniper_50
	name = "\improper .50 sniper magazine"
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
