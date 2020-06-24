/obj/item/magazine/rifle_545mm
	name = "\improper 5.45x39mm magazine"
	icon = 'icons/obj/items/magazine/545.dmi'
	icon_state = "m545m"
	bullet_count_max = 30

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/abakan = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/rifle_545mm

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 5.4
	bullet_diameter_best = 5.45
	bullet_diameter_max = 5.46

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/magazine/rifle_545mm/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]_0"

	..()

/obj/item/magazine/rifle_939mm
	name = "\improper 9x39mm magazine"
	icon = 'icons/obj/items/magazine/939.dmi'

	ammo = /obj/item/bullet_cartridge/rifle_939mm

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/magazine/rifle_939mm/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]_0"

	..()

/obj/item/magazine/rifle_939mm/vintorez
	name = "\improper 9x39mm VSS magazine"
	icon_state = "sp9x39vint"
	bullet_count_max = 10

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez = TRUE,
	)

/obj/item/magazine/rifle_939mm/val
	name = "\improper 9x39mm AS Val magazine"
	icon_state = "sp9x39val"
	bullet_count_max = 20

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/val = TRUE,
	)

/obj/item/magazine/rifle_939mm/groza
	name = "\improper 9x39mm Groza magazine"
	icon_state = "sp9x39groza"
	bullet_count_max = 30

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/groza = TRUE,
	)

