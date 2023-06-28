/obj/item/magazine/smg_9mm
	name = "\improper 9x19mm banana magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/9mm_smg_alt.dmi'
	icon_state = "10mmsmg"
	bullet_count_max = 30

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/tactical = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/smg/tactical/equipped = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/smg/tactical/corporate = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/smg/handheld = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_9mm
	ammo_surplus = /obj/item/bullet_cartridge/pistol_9mm/surplus

	size = SIZE_2

	value = 10


/obj/item/magazine/smg_9mm/update_icon()
	icon_state = "[initial(icon_state)]_[get_ammo_count() ? 1 : 0]"
	return ..()