/obj/item/magazine/pistol_12mm
	name = "\improper 12.7mm pistol magazine"
	bullet_type = "12.7"
	icon = 'icons/obj/items/magazine/12mm_pistol.dmi'
	icon_state = "12mm"
	bullet_count_max = 8

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre
	)

	ammo = /obj/item/bullet_cartridge/pistol_12mm

/obj/item/magazine/pistol_12mm/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()