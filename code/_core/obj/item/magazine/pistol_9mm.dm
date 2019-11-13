/obj/item/magazine/pistol_9mm
	name = "\improper 9mm machine pistol magazine"
	bullet_type = ".50ae"
	icon = 'icons/obj/items/magazine/9mmpistol.dmi'
	icon_state = "9mm"
	bullet_count_max = 15

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/pistol/machine
	)

/obj/item/magazine/pistol_9mm/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/pistol_9mm(src)
	update_icon()

/obj/item/magazine/pistol_9mm/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()