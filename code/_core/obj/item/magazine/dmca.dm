/obj/item/magazine/dmca
	name = "\improper 10x24mm caseless DMCA magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "A highly advanced magazine that uses special Solarian quadruple stacked loading techniques to supply a high rate of fire 4 round burst to the DMCA."
	icon = 'icons/obj/item/magazine/dmca.dmi'
	icon_state = "dmca"
	bullet_count_max = 99

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/dmca = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_10x24mm
	ammo_surplus = /obj/item/bullet_cartridge/pistol_10x24mm/surplus

	bullet_length_min = 23
	bullet_length_best = 24
	bullet_length_max = 24

	bullet_diameter_min = 9
	bullet_diameter_best = 10
	bullet_diameter_max = 10

	size = SIZE_3

	icon_states = 1

	value = 100


/obj/item/magazine/dmca/he
	name = "\improper 10x24mm HEAP caseless DMCA magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "A highly advanced magazine that uses special Solarian quadruple stacked loading techniques to supply a high rate of fire 4 round burst to the DMCA. This one contains high explosive rounds."
	icon = 'icons/obj/item/magazine/dmca_he.dmi'
	icon_state = "dmca"

	ammo = /obj/item/bullet_cartridge/pistol_10x24mm/explosive
	ammo_surplus = /obj/item/bullet_cartridge/pistol_10x24mm/surplus

	value = 100