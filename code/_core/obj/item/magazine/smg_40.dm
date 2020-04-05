/obj/item/magazine/smg_40
	name = "\improper .40 smg magazine"
	icon = 'icons/obj/items/magazine/40smg.dmi'
	icon_state = "40"
	bullet_count_max = 36

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg/nanotech
	)

	ammo = /obj/item/bullet_cartridge/pistol_40

/obj/item/magazine/smg_45/update_icon()
	icon_state = "[initial(icon_state)]_[FLOOR((length(stored_bullets)/bullet_count_max)*12,1)]"
	..()