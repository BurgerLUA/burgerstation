/obj/item/magazine/pistol_10mm
	name = "\improper 10mm auto pistol magazine"
	bullet_type = "10mm"
	icon = 'icons/obj/items/magazine/10mmpistol.dmi'
	icon_state = "10mmpistol"
	bullet_count_max = 8

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/syndie
	)

	ammo = /obj/item/bullet_cartridge/pistol_10mm

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