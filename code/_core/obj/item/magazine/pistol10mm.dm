/obj/item/magazine/pistol_10mm
	name = "\improper 10mm auto pistol magazine"
	icon = 'icons/obj/items/magazine/10mmpistol.dmi'
	icon_state = "10mmpistol"
	bullet_count_max = 8

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie,
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/mod
	)

	ammo = /obj/item/bullet_cartridge/pistol_10mm

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

/obj/item/magazine/pistol_10mm/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()

/*
/obj/item/magazine/pistol_10mm/surplus
	name = "\improper surplus 10mm auto pistol magazine"

	ammo = /obj/item/bullet_cartridge/pistol_10mm/surplus
*/