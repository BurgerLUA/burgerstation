/obj/item/magazine/sniper_50
	name = "\improper .50 sniper magazine"
	icon = 'icons/obj/items/magazine/50_sniper.dmi'
	icon_state = "50"
	bullet_count_max = 4

	bullet_length_min = 90
	bullet_length_best = 99
	bullet_length_max = 100

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper = TRUE
	)

	ammo = /obj/item/bullet_cartridge/sniper_50

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/magazine/sniper_50/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]_0"

	..()