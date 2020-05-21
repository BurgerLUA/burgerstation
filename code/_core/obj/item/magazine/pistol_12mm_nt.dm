/obj/item/magazine/pistol_12mm/nt
	name = "\improper 12.7mm pistol magazine"
	icon = 'icons/obj/items/magazine/12mmpistol2.dmi'
	icon_state = "12mm"
	bullet_count_max = 8

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre/mod = TRUE,
		/obj/item/weapon/ranged/bullet/magazine/pistol/overseer = TRUE
	)

	ammo = /obj/item/bullet_cartridge/pistol_12mm

	bullet_length_min = 27
	bullet_length_best = 33
	bullet_length_max = 34

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

/obj/item/magazine/pistol_12mm/nt/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets)]"
