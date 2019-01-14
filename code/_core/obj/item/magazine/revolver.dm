/obj/item/magazine/clip/revolver/update_icon()
	var/number = length(stored_bullets)
	if(number == 0)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_[number]"

	..()

/obj/item/magazine/clip/revolver/bullet_38
	name = ".38 clip"
	icon = 'icons/obj/items/magazine/revolver/38.dmi'
	icon_state = "38"
	bullet_capacity = 6

/obj/item/magazine/clip/revolver/bullet_38/full/add_ammo()
	for(var/i=1, i <= bullet_capacity, i++)
		stored_bullets += new /obj/item/bullet/revolver_38(src)