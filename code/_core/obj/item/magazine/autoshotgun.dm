/obj/item/magazine/shotgun_auto
	name = "\improper 12 gauge autoshotgun magazine"
	bullet_type = "shotgun"
	icon = 'icons/obj/items/magazine/auto_shotgun.dmi'
	icon_state = "auto"
	bullet_count_max = 9

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/autoshotgun
	)

/obj/item/magazine/shotgun_auto/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets)]"
	..()

/obj/item/magazine/shotgun_auto/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/shotgun/buckshot(src)
	update_icon()