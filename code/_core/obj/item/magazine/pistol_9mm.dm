/obj/item/magazine/pistol_9mm
	name = "\improper 9mm pistol magazine"
	bullet_type = "9"
	icon = 'icons/obj/items/magazine/9mmpistol_2.dmi'
	icon_state = "9mm"
	bullet_count_max = 18

	weapon_whitelist = list(

	)

	ammo = /obj/item/bullet/pistol_9mm

/obj/item/magazine/pistol_9mm/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_[ceiling(length(stored_bullets)/2)]"
	else
		icon_state = "[initial(icon_state)]"

	..()