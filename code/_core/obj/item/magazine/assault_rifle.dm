/obj/item/magazine/rifle_762
	name = "\improper 7.62mm magazine"
	bullet_type = "7.62"
	icon = 'icons/obj/items/magazine/762.dmi'
	icon_state = "762"
	bullet_capacity = 30

/obj/item/magazine/rifle_762/on_spawn()
	for(var/i=1, i <= bullet_capacity, i++)
		stored_bullets += new /obj/item/bullet/rifle_762(src)
	update_icon()

/obj/item/magazine/rifle_762/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()