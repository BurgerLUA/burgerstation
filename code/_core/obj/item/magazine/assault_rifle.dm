/obj/item/magazine/rifle_762
	name = "\improper 7.62mm magazine"
	bullet_type = "7.62"
	icon = 'icons/obj/items/magazine/762.dmi'
	icon_state = "762"
	bullet_count_max = 30

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/assault_rifle
	)

/obj/item/magazine/rifle_762/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/rifle_762(src)
	update_icon()

/obj/item/magazine/rifle_762/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()



/obj/item/magazine/rifle_762/surplus
	name = "\improper surplus 7.62mm magazine"


/obj/item/magazine/rifle_762/surplus/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/rifle_762/surplus(src)
	update_icon()
