/obj/item/magazine/pistol_10mm
	name = "\improper 10mm auto pistol magazine"
	bullet_type = "10mm_auto"
	icon = 'icons/obj/items/magazine/10mmpistol.dmi'
	icon_state = "10mmpistol"
	bullet_capacity = 8

/obj/item/magazine/pistol_10mm/on_spawn()
	for(var/i=1, i <= bullet_capacity, i++)
		stored_bullets += new /obj/item/bullet/pistol_10mm(src)

/obj/item/magazine/pistol_10mm/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()