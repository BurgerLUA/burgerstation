/obj/item/magazine/box/buckshot
	name = "box of buckshot bullets"
	desc = "A box of buckshot bullets for easy carrying needs. Packaged in 12 shells."
	icon = 'icons/obj/items/bullet/boxes.dmi'
	icon_state = "buckshot"
	bullet_type = "shotgun"
	bullet_count_max = 12

/obj/item/magazine/box/buckshot/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/shotgun/buckshot(src)