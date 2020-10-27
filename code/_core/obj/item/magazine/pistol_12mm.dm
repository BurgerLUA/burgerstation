/obj/item/magazine/pistol_12mm
	name = "\improper 12.7mm pistol magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/12mmpistol2.dmi'
	icon_state = "12mm"
	bullet_count_max = 8

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre/mod = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/overseer = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_12mm

	bullet_length_min = 27
	bullet_length_best = 33
	bullet_length_max = 34

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	size = SIZE_2

	icon_states = 8

	value = 5

/obj/item/magazine/pistol_12mm/ap
	name = "\improper 12.7mm AP pistol magazine"
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber. This one contains AP rounds."
	ammo = /obj/item/bullet_cartridge/pistol_12mm/ap