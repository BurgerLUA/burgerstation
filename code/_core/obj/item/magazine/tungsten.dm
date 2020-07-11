/obj/item/magazine/rifle_tungsten
	name = "\improper tungsten magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/tungsten.dmi'
	icon_state = "t"
	bullet_count_max = 10

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/tungsten

	bullet_length_min = 15
	bullet_length_best = 20
	bullet_length_max = 25

	bullet_diameter_min = 4
	bullet_diameter_best = 5
	bullet_diameter_max = 6

	size = SIZE_2


/obj/item/magazine/rifle_tungsten/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets)]"
	return TRUE