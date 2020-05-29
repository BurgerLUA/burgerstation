/obj/item/magazine/pistol_9mm
	name = "\improper 9mm pistol magazine"
	icon = 'icons/obj/items/magazine/9mmpistol.dmi'
	icon_state = "9mm"
	bullet_count_max = 18

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/military = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/military/mod = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/military/nanotrasen = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_9mm

	bullet_length_min = 21
	bullet_length_best = 22
	bullet_length_max = 23

	bullet_diameter_min = 9.8
	bullet_diameter_best = 10
	bullet_diameter_max = 11.2

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/magazine/pistol_9mm/update_icon()
	icon_state = "[initial(icon_state)]_[CEILING(length(stored_bullets)/2,1)]"
	return ..()
