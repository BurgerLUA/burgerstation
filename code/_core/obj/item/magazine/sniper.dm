/obj/item/magazine/sniper_50
	name = "\improper .50 magazine"
	bullet_type = ".50"
	icon = 'icons/obj/items/magazine/50.dmi'
	icon_state = "50"
	bullet_count_max = 4

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/heavy_sniper
	)

/obj/item/magazine/sniper_50/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/sniper_50(src)
	update_icon()

/obj/item/magazine/sniper_50/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()



/obj/item/magazine/sniper_50/surplus
	name = "\improper surplus .50 magazine"



/obj/item/magazine/sniper_50/surplus/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/sniper_50/surplus(src)
	update_icon()