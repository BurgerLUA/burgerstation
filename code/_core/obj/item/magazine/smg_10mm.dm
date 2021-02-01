/obj/item/magazine/smg_10mm
	name = "\improper 10mm smg magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/10mmsmg.dmi'
	icon_state = "10mmsmg"
	bullet_count_max = 30

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11


	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/fbi = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/smg/fbi/mod = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/smg/tactical = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/smg/tactical/equipped = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/smg/tactical/nt = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_10mm

	size = SIZE_2

	value = 10


/obj/item/magazine/smg_10mm/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets) ? 1 : 0]"
	return ..()