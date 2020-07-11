/obj/item/magazine/pistol_10mm
	name = "\improper 10mm auto pistol magazine"
	desc = "IT'S NOT A CLIP. IT'S A MAGAZINE."
	desc_extended = "Contains ammunition for a ranged weapon. Make sure you're trying to use the right caliber."
	icon = 'icons/obj/item/magazine/10mmpistol.dmi'
	icon_state = "10mmpistol"
	bullet_count_max = 8

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/mod = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_power = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_10mm

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

	size = SIZE_2


/obj/item/magazine/pistol_10mm/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]_0"
	..()