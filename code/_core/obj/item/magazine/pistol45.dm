/obj/item/magazine/pistol_45
	name = "\improper .45 pistol magazine"
	bullet_type = ".45"
	icon = 'icons/obj/items/magazine/45pistol.dmi'
	icon_state = "45"
	bullet_count_max = 7

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/autopistol,
		/obj/item/weapon/ranged/bullet/magazine/pistol/secpistol
	)

/obj/item/magazine/pistol_45/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/pistol_45(src)
	update_icon()

/obj/item/magazine/pistol_45/update_icon()
	icon_state = "[initial(icon_state)]_[length(stored_bullets)]"
	..()