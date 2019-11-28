/obj/item/magazine/smg_45
	name = "\improper .45 smg magazine"
	bullet_type = ".45"
	icon = 'icons/obj/items/magazine/45smg.dmi'
	icon_state = "c20r45"
	bullet_count_max = 24

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smg,
		/obj/item/weapon/ranged/bullet/magazine/smg/tactical
	)

/obj/item/magazine/smg_45/update_icon()
	icon_state = "[initial(icon_state)]-[round(length(stored_bullets),2)]"
	..()

/obj/item/magazine/smg_45/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/pistol_45/(src)
	update_icon()



/obj/item/magazine/smg_22/
	name = "\improper .22 smg magazine"
	bullet_type = ".22"
	icon = 'icons/obj/items/magazine/22smg.dmi'
	icon_state = "22"
	bullet_count_max = 28*2

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/bull
	)

/obj/item/magazine/smg_22/update_icon()
	icon_state = "[initial(icon_state)]-[ceiling(length(stored_bullets)/2,2)]"
	..()

/obj/item/magazine/smg_22/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/revolver_22(src)
	update_icon()


/obj/item/magazine/smg_22/surplus
	name = "\improper surplus .22 smg magazine"

/obj/item/magazine/smg_22/surplus/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/revolver_22/surplus(src)
	update_icon()