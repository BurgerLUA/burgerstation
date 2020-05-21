/obj/item/magazine/gyrojet
	name = "\improper 20mm gyrojet magazine"
	icon = 'icons/obj/items/magazine/gyrojet.dmi'
	icon_state = "gyrojet"
	bullet_count_max = 4

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/gyrojet = TRUE
	)

	ammo = /obj/item/bullet_cartridge/gyrojet

	bullet_length_min = 48
	bullet_length_best = 50
	bullet_length_max = 52

	bullet_diameter_min = 19
	bullet_diameter_best = 20
	bullet_diameter_max = 21

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/magazine/gyrojet/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]_0"