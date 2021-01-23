/obj/item/magazine/shotgun_auto
	name = "\improper 20g bulldog magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains slug shells for a magazine-fed bullpup shotgun. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/auto_shotgun.dmi'
	icon_state = "auto"
	bullet_count_max = 9

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/shotgun/bulldog = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/shotgun/saiga_20 = TRUE
	)

	ammo = /obj/item/bullet_cartridge/shotgun_20/slug

	bullet_length_min = 17
	bullet_length_best = 17.5
	bullet_length_max = 18

	bullet_diameter_min = 17
	bullet_diameter_best = 17.5
	bullet_diameter_max = 18

	size = SIZE_2

	icon_states = 9

	value = 15

/obj/item/magazine/shotgun_auto/empty
	ammo = null

/obj/item/magazine/shotgun_auto/buckshot
	name = "\improper 20g bulldog magazine (buckshot)"
	ammo = /obj/item/bullet_cartridge/shotgun_20/buckshot

/obj/item/magazine/shotgun_auto/slug
	name = "\improper 20g bulldog magazine magazine (slug)"
	ammo = /obj/item/bullet_cartridge/shotgun_20/slug