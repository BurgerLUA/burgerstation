/obj/item/magazine/bizon_9mm
	name = "\improper 9mm Bizon magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/9mm_bizon.dmi'
	icon_state = "9mm"
	bullet_count_max = 64

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/bizon = TRUE,
	)

	ammo = /obj/item/bullet_cartridge/pistol_9mm

	size = SIZE_2

	icon_states = 1

	value = 15