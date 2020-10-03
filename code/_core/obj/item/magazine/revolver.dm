/obj/item/magazine/clip/revolver/bullet_38
	name = "\improper .38 six round speedloader"
	desc = "IT'S NOT A CLIP. IT'S A MA-- Wait, what?"
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/revolver/38.dmi'
	icon_state = "38"
	bullet_count_max = 6

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/revolver/detective = TRUE
	)

	ammo = /obj/item/bullet_cartridge/revolver_38

	bullet_length_min = 10
	bullet_length_best = 29
	bullet_length_max = 30

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	size = SIZE_1

	icon_states = 6


/obj/item/magazine/clip/revolver/bullet_38/eight
	name = "\improper .38 eight round speedloader"
	desc = "IT'S NOT A CLIP. IT'S A MA-- Wait, what?"
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/revolver/38_2.dmi'
	bullet_count_max = 8

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/revolver/comp = TRUE
	)

	icon_states = 8


/obj/item/magazine/clip/revolver/bullet_44
	name = "\improper .44 revolver speedloader"
	desc = "IT'S NOT A CLIP. IT'S A MA-- Wait, what?"
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/revolver/44.dmi'
	icon_state = "44"
	bullet_count_max = 6

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/revolver/commander = TRUE,
		/obj/item/weapon/ranged/bullet/revolver/deckhard = TRUE
	)

	ammo = /obj/item/bullet_cartridge/revolver_44

	bullet_length_min = 10
	bullet_length_best = 29
	bullet_length_max = 30

	bullet_diameter_min = 10
	bullet_diameter_best = 10.9
	bullet_diameter_max = 11

	size = SIZE_1

	icon_states = 6

/obj/item/magazine/clip/revolver/bullet_357
	name = "\improper .357 speedloader"
	desc = "IT'S NOT A CLIP. IT'S A MA-- Wait, what?"
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/revolver/357.dmi'
	icon_state = "357"
	bullet_count_max = 6

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/revolver/traitor_357 = TRUE
	)

	ammo = /obj/item/bullet_cartridge/revolver_357

	bullet_length_min = 20
	bullet_length_best = 33
	bullet_length_max = 35

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	size = SIZE_1

	icon_states = 6