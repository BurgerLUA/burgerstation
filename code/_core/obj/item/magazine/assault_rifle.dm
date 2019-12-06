/obj/item/magazine/rifle_556
	name = "\improper 5.56mm magazine"
	bullet_type = "5.56"
	icon = 'icons/obj/items/magazine/556.dmi'
	icon_state = "556"
	bullet_count_max = 30

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/assault_rifle
	)

/obj/item/magazine/rifle_556/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/rifle_556(src)
	update_icon()

/obj/item/magazine/rifle_556/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()

/obj/item/magazine/rifle_556/surplus
	name = "\improper surplus 5.56mm magazine"

/obj/item/magazine/rifle_556/surplus/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/rifle_556/surplus(src)
	update_icon()
