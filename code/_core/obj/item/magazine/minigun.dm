/obj/item/magazine/minigun_46
	name = "\improper 4.6x30mm caseless large magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/minigun.dmi'
	icon_state = "mini"
	bullet_count_max = 200

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/minigun = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/misc/sentry = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/dmca = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_4mm/caseless

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

	size = SIZE_3

	icon_states = 1

	value = 50