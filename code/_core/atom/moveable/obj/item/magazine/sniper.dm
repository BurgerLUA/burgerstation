/obj/item/magazine/sniper50
	name = "\improper .50 magazine"
	bullet_type = ".50"
	icon = 'icons/obj/items/magazine/50.dmi'
	icon_state = "50"
	bullet_capacity = 4

/obj/item/magazine/sniper50/on_spawn()
	for(var/i=1, i <= bullet_capacity, i++)
		stored_bullets += new /obj/item/bullet/sniper_50(src)

/obj/item/magazine/sniper50/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()