/obj/item/magazine/smg_45
	name = "\improper .45 banana magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/45_smg.dmi'
	icon_state = "45"
	bullet_count_max = 25

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/bullpup = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/mod = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/smg/fbi = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/pistol_45
	ammo_surplus = /obj/item/bullet_cartridge/pistol_45/surplus

	size = SIZE_2

	value = 10

/obj/item/magazine/smg_45/update_icon()
	. = ..()
	icon_state = "[initial(icon_state)]_[get_ammo_count() ? 1 : 0]"

/obj/item/magazine/smg_45/ap
	name = "\improper .45 AP banana magazine"
	icon = 'icons/obj/item/magazine/45_smg_ap.dmi'
	icon_state = "45"
	ammo = /obj/item/bullet_cartridge/pistol_45/ap
	rarity = RARITY_UNCOMMON