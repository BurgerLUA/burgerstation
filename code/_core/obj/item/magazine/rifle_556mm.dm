/obj/item/magazine/rifle_556
	name = "\improper 5.56mm rifle magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/556_rifle.dmi'
	icon_state = "556"
	bullet_count_max = 30

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle/nt_carbine = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/standard = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/rifle/civ_carbine = TRUE

	)

	ammo = /obj/item/bullet_cartridge/rifle_223

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	size = SIZE_2


/obj/item/magazine/rifle_556/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets) ? 1 : 0]"
	return ..()