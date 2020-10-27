/obj/item/magazine/pistol_50
	name = "\improper .50 pistol magazine"
	desc = "Not compatible with the 'Degle'."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/50aepistol.dmi'
	icon_state = "50ae"
	bullet_count_max = 7

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/deagle = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/deagle/mod = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_50

	bullet_length_min = 30
	bullet_length_best = 33
	bullet_length_max = 36

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	size = SIZE_2

	icon_states = 7

	value = 5