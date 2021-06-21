/obj/item/magazine/browning_127
	name = "\improper 12.7x99mm browning magazine"
	desc = "IT'S NOT A MAGAZINE. IT'S A BELT."
	desc_extended = "Contains ammunition for a mounted weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/127_browning.dmi'
	icon_state = "127browning"

	bullet_count_max = 200

	bullet_length_min = 90
	bullet_length_best = 99
	bullet_length_max = 100

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/misc/browning = TRUE
	)

	ammo = /obj/item/bullet_cartridge/bmg_50
	ammo_surplus = /obj/item/bullet_cartridge/bmg_50/surplus

	size = SIZE_3
	weight = 9

	icon_states = 1

	value = 1000