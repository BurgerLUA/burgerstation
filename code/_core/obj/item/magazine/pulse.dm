/obj/item/magazine/pulse_rifle
	name = "\improper pulse rifle magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/pulse.dmi'
	icon_state = "battery"
	bullet_count_max = 12

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/pulse = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pulse

	bullet_length_min = 52
	bullet_length_best = 52
	bullet_length_max = 52

	bullet_diameter_min = 13
	bullet_diameter_best = 13
	bullet_diameter_max = 13

	size = SIZE_3

	icon_states = 6

	value = 10