/obj/item/magazine/saiga_23
	name = "\improper 23x75mmR Saiga-23 magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains slug shells for a magazine-fed AK-based shotgun. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/23_shotgun.dmi'
	icon_state = "auto"
	bullet_count_max = 9

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/shotgun/saiga_23 = TRUE
	)

	ammo = /obj/item/bullet_cartridge/shotgun_23/slug

	bullet_length_min = 73
	bullet_length_best = 75
	bullet_length_max = 78

	bullet_diameter_min = 21
	bullet_diameter_best = 23
	bullet_diameter_max = 25

	size = SIZE_2

	icon_states = 9

	value = 15

/obj/item/magazine/saiga_23/empty
	ammo = null

/obj/item/magazine/saiga_23/buckshot
	name = "\improper 23x75mmR Saiga-23 magazine (buckshot)"
	ammo = /obj/item/bullet_cartridge/shotgun_23/buckshot

/obj/item/magazine/saiga_23/slug
	name = "\improper 23x75mmR Saiga-23 magazine magazine (slug)"
	ammo = /obj/item/bullet_cartridge/shotgun_23/slug