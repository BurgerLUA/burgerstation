/obj/item/magazine/sniper_127
	name = "\improper 12.7x90mm sniper magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/127_sniper.dmi'
	icon_state = "12"
	bullet_count_max = 4

	bullet_length_min = 80
	bullet_length_best = 90
	bullet_length_max = 95

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127 = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127/equipped = TRUE
	)

	ammo = /obj/item/bullet_cartridge/sniper_127

	size = SIZE_2

	icon_states = 1

	value = 20