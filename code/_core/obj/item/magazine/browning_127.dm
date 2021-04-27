/obj/item/magazine/browning_127
	name = "\improper 12.7x90mm browning magazine"
	desc = "IT'S NOT A MAGAZINE. IT'S A BELT."
	desc_extended = "Contains ammunition for a mounted weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/127_browning.dmi'
	icon_state = "127browning"

	bullet_count_max = 200

	bullet_length_min = 80
	bullet_length_best = 90
	bullet_length_max = 95

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/misc/browning = TRUE
	)

	ammo = /obj/item/bullet_cartridge/sniper_127
	ammo_surplus = /obj/item/bullet_cartridge/sniper_127/surplus

	size = SIZE_4
	weight = 9

	icon_states = 1

	value = 1000