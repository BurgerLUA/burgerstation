/obj/item/magazine/pistol_12mm
	name = "\improper 12.7mm pistol magazine"
	icon = 'icons/obj/items/magazine/12mm_pistol.dmi'
	icon_state = "12mm"
	bullet_count_max = 8

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre/mod
	)

	ammo = /obj/item/bullet_cartridge/pistol_12mm

	bullet_length_min = 27
	bullet_length_best = 33
	bullet_length_max = 34

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

/obj/item/magazine/pistol_12mm/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]_0"

	..()