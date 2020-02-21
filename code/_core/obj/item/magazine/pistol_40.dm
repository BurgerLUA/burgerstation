/obj/item/magazine/pistol_40
	name = "\improper .40 pistol magazine"
	icon = 'icons/obj/items/magazine/40pistol.dmi'
	icon_state = "40"
	bullet_count_max = 18

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/military,
		/obj/item/weapon/ranged/bullet/magazine/pistol/military/mod
	)

	ammo = /obj/item/bullet_cartridge/pistol_40

	bullet_length_min = 21
	bullet_length_best = 22
	bullet_length_max = 23

	bullet_diameter_min = 9.8
	bullet_diameter_best = 10
	bullet_diameter_max = 11.2

/obj/item/magazine/pistol_40/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_[ceiling(length(stored_bullets)/2)]"
	else
		icon_state = "[initial(icon_state)]"

	..()