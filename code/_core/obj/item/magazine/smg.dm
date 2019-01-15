/obj/item/magazine/smg_45
	name = "\improper .45 smg magazine"
	id = ".45"
	icon = 'icons/obj/items/magazine/45.dmi'
	icon_state = "c20r45"
	bullet_capacity = 24

/obj/item/magazine/smg_45/update_icon()
	icon_state = "[initial(icon_state)]-[round(length(stored_bullets),2)]"
	..()

/obj/item/magazine/smg_45/full/add_ammo()
	for(var/i=1, i <= bullet_capacity, i++)
		stored_bullets += new /obj/item/bullet/smg_45(src)