/obj/item/magazine/halo/kv32
	name = "KV-32 magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains slug shells for a magazine-fed shotgun. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/kv32.dmi'
	icon_state = "kv"
	bullet_count_max = 4

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/shotgun/halo/kv32 = TRUE
	)

	ammo = /obj/item/bullet_cartridge/shotgun_12/buckshot

	bullet_length_min = 18
	bullet_length_best = 18.5
	bullet_length_max = 19

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19

	size = SIZE_1

	icon_states = 1

	value = 200