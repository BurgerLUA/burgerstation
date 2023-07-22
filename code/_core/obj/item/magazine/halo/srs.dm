/obj/item/magazine/halo/srs
	name = "\improper magazine (14.5mm) M112 AP-FS-DS"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/srs.dmi'
	icon_state = "srss"
	bullet_count_max = 4

	bullet_length_min = 90
	bullet_length_best = 99
	bullet_length_max = 100

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs/insurrection = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs = TRUE
	)

	ammo = /obj/item/bullet_cartridge/sniper_50

	size = SIZE_2

	icon_states = 1

	value = 150

/obj/item/magazine/halo/srs/explosive
	name = "\improper (14.5mm) M112 - explosive"
	icon_state = "srse"
	ammo = /obj/item/bullet_cartridge/sniper_50/explosive
	value = 500

/obj/item/magazine/halo/srs/incendiary
	name = "\improper (14.5mm) M112 - incendiary"
	icon_state = "srsi"
	ammo = /obj/item/bullet_cartridge/sniper_50/incendiary
	value = 300

/obj/item/magazine/halo/srs/ap
	name = "\improper (14.5mm) M112 - armor piercing"
	icon_state = "srsa"
	ammo = /obj/item/bullet_cartridge/sniper_50/ap
	value = 250