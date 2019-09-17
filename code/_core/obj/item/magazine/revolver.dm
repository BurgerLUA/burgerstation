/obj/item/magazine/clip/revolver/update_icon()
	var/number = length(stored_bullets)
	if(number == 0)
		icon_state = initial(icon_state)
	else
		icon_state = "[initial(icon_state)]_[number]"

	..()

/obj/item/magazine/clip/revolver/bullet_38
	name = "\improper .38 speedloader"
	bullet_type = ".38"
	icon = 'icons/obj/items/magazine/revolver/38.dmi'
	icon_state = "38"
	bullet_count_max = 6

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/revolver/detective
	)

/obj/item/magazine/clip/revolver/bullet_38/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/revolver_38(src)

/obj/item/magazine/clip/revolver/bullet_44
	name = "\improper .44 magnum speedloader"
	bullet_type = ".44"
	icon = 'icons/obj/items/magazine/revolver/44.dmi'
	icon_state = "44"
	bullet_count_max = 7

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/revolver/mateba
	)

/obj/item/magazine/clip/revolver/bullet_44/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/revolver_44(src)

/obj/item/magazine/clip/revolver/bullet_22
	name = "\improper .22LR speedloader"
	bullet_type = ".22"
	icon = 'icons/obj/items/magazine/revolver/22.dmi'
	icon_state = "22"
	bullet_count_max = 6

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/revolver/deckhard
	)

/*
/obj/item/magazine/clip/revolver/bullet_22/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/revolver_22(src)
*/