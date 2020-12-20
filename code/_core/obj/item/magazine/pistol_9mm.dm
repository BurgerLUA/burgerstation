/obj/item/magazine/pistol_9mm
	name = "\improper 9mm pistol magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/9mmpistol.dmi'
	icon_state = "9mm"
	bullet_count_max = 18

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/military = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/military/nanotrasen = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/laton = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/yarygin = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_9mm

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

	bullet_length_min = 18
	bullet_length_best = 19
	bullet_length_max = 20

	size = SIZE_2

	icon_states = 9

	value = 5