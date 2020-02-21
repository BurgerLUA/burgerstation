/obj/item/magazine/shotgun_auto
	name = "\improper 12 gauge AS-12 magazine"
	bullet_type = "shotgun"
	icon = 'icons/obj/items/magazine/auto_shotgun.dmi'
	icon_state = "auto"
	bullet_count_max = 9

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/shotgun/bull
	)

	ammo = /obj/item/bullet_cartridge/shotgun/slug

/obj/item/magazine/shotgun_auto/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets)]"
	..()