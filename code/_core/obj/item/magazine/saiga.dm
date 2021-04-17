/obj/item/magazine/saiga_auto
	name = "\improper 12g saiga magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains slug shells for a magazine-fed AK-pattern shotgun. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/saiga_auto.dmi'
	icon_state = "saiga"
	bullet_count_max = 10

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/shotgun/saiga_12 = TRUE
	)

	ammo = /obj/item/bullet_cartridge/shotgun_12/slug
	ammo_surplus = /obj/item/bullet_cartridge/shotgun_12/slug/surplus

	bullet_length_min = 17
	bullet_length_best = 17.5
	bullet_length_max = 18

	bullet_diameter_min = 17
	bullet_diameter_best = 17.5
	bullet_diameter_max = 18

	size = SIZE_2

	icon_states = 9

	value = 15

/obj/item/magazine/saiga_auto/empty
	ammo = null

/obj/item/magazine/saiga_auto/buckshot
	name = "\improper 12g saiga magazine (buckshot)"
	ammo = /obj/item/bullet_cartridge/shotgun_12/buckshot
	ammo_surplus = /obj/item/bullet_cartridge/shotgun_12/buckshot/surplus

/obj/item/magazine/saiga_auto/slug
	name = "\improper 12g saiga magazine (slug)"
	ammo = /obj/item/bullet_cartridge/shotgun_12/slug

/obj/item/magazine/saiga_auto/flechette
	name = "\improper 12g saiga magazine (flechette)"
	ammo = /obj/item/bullet_cartridge/shotgun_12/flechette

/obj/item/magazine/saiga_auto/fire
	name = "\improper 12g saiga magazine (incendiary)"
	ammo = /obj/item/bullet_cartridge/shotgun_12/fire