/obj/item/magazine/lmg_556
	name = "\improper 5.56mm lmg magazine"
	bullet_type = "5.56"
	icon = 'icons/obj/items/magazine/556lmg.dmi'
	icon_state = "556"
	bullet_capacity = 50

/obj/item/magazine/lmg_556/on_spawn()
	for(var/i=1, i <= bullet_capacity, i++)
		stored_bullets += new /obj/item/bullet/rifle_556(src)
	update_icon()

/obj/item/magazine/lmg_556/update_icon()
	icon_state = "[initial(icon_state)]_[round(length(stored_bullets),10)]"
	..()
