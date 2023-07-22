/obj/item/magazine/halo/m41
	name = "M21 antipersonnel rocket"
	desc = "What makes ME a good demoman?"
	desc_extended = "The M21 antipersonnel rocket is a special warfare munition capable of being fired from the M41 SPNKR rocket launcher."
	icon = 'icons/obj/item/magazine/m41.dmi'
	icon_state = "spnkr"
	bullet_count_max = 2

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m41 = TRUE
	)

	ammo = /obj/item/bullet_cartridge/halo/spnkr

	bullet_length_min = 45
	bullet_length_best = 46
	bullet_length_max = 47

	bullet_diameter_min = 39
	bullet_diameter_best = 40
	bullet_diameter_max = 41

	size = SIZE_4

	icon_states = 2

	value = 100