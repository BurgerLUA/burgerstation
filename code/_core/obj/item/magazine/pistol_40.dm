/obj/item/magazine/pistol_40
	name = "\improper .40 pistol magazine"
	bullet_type = ".40"
	icon = 'icons/obj/items/magazine/40pistol.dmi'
	icon_state = "40"
	bullet_count_max = 18

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/military,
		/obj/item/weapon/ranged/bullet/magazine/pistol/military/mod
	)

	ammo = /obj/item/bullet_cartridge/pistol_40

/obj/item/magazine/pistol_40/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_[ceiling(length(stored_bullets)/2)]"
	else
		icon_state = "[initial(icon_state)]"

	..()