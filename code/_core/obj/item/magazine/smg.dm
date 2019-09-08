/obj/item/magazine/smg_45
	name = "\improper .45 smg magazine"
	bullet_type = ".45"
	icon = 'icons/obj/items/magazine/45smg.dmi'
	icon_state = "c20r45"
	bullet_capacity = 24

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg,
		/obj/item/weapon/ranged/bullet/magazine/smg/tactical
	)

/obj/item/magazine/smg_45/update_icon()
	icon_state = "[initial(icon_state)]-[round(length(stored_bullets),2)]"
	..()

/obj/item/magazine/smg_45/on_spawn()
	for(var/i=1, i <= bullet_capacity, i++)
		stored_bullets += new /obj/item/bullet/pistol_45/(src)
	update_icon()