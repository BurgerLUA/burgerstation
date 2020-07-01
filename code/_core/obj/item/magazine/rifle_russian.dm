/obj/item/magazine/rifle_939
	name = "\improper 9x39mm magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/939.dmi'

	ammo = /obj/item/bullet_cartridge/rifle_939mm

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/magazine/rifle_939/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]_0"

	..()

/obj/item/magazine/rifle_939/vintorez
	name = "\improper 9x39mm VSS magazine"
	icon_state = "sp9x39vint"
	bullet_count_max = 10

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/vintorez = TRUE,
	)

/obj/item/magazine/rifle_939/val
	name = "\improper 9x39mm AS Val magazine"
	icon = 'icons/obj/item/magazine/939_val.dmi'
	icon_state = "val"
	bullet_count_max = 20

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/val = TRUE,
	)

/obj/item/magazine/rifle_939/groza
	name = "\improper 9x39mm Groza magazine"
	icon = 'icons/obj/item/magazine/939_groza.dmi'
	icon_state = "groza"
	bullet_count_max = 30

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/groza = TRUE,
	)

