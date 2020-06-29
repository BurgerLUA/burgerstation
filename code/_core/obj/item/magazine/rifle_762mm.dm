/obj/item/magazine/rifle_762
	name = "\improper 7.62mm rifle magazine"
	icon = 'icons/obj/items/magazine/762_rifle.dmi'
	icon_state = "762"
	bullet_count_max = 20

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/service = TRUE
	)

	ammo = /obj/item/bullet_cartridge/rifle_308/nato

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/magazine/sniper_762/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]_0"

	..()
