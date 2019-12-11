/obj/item/magazine/smp_9mm
	name = "\improper 9mm smp magazine"
	bullet_type = ".50ae"
	icon = 'icons/obj/items/magazine/9mmsmp.dmi'
	icon_state = "smp"
	bullet_count_max = 27

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/smp
	)

/obj/item/magazine/smp_9mm/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/pistol_9mm(src)
	update_icon()

/obj/item/magazine/smp_9mm/update_icon()

	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_[round(length(stored_bullets),3)]"
	else
		icon_state = "[initial(icon_state)]"

	..()

/obj/item/magazine/smp_9mm/surplus
	name = "surplus 9mm smp magazine"

/obj/item/magazine/smp_9mm/surplus/on_spawn()
	for(var/i=1, i <= bullet_count_max, i++)
		stored_bullets += new /obj/item/bullet/pistol_9mm/surplus(src)
	update_icon()