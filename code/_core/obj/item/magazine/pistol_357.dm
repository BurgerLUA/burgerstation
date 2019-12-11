/obj/item/magazine/pistol_357
	name = "\improper .357 pistol magazine"
	bullet_type = ".357"
	icon = 'icons/obj/items/magazine/357pistol.dmi'
	icon_state = "357"
	bullet_count_max = 7

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/mercenary
	)

/obj/item/magazine/pistol_357/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/revolver_357(src)
	update_icon()

/obj/item/magazine/pistol_357/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()