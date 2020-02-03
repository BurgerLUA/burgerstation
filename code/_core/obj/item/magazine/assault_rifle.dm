/obj/item/magazine/rifle_223
	name = "\improper .223 magazine"
	bullet_type = ".223"
	icon = 'icons/obj/items/magazine/223_rifle.dmi'
	icon_state = "223"
	bullet_count_max = 30

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle,
	)

	ammo = /obj/item/bullet/rifle_223

/obj/item/magazine/rifle_223/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()

/obj/item/magazine/rifle_223/surplus
	name = "\improper surplus .223 magazine"
	ammo = /obj/item/bullet/rifle_223/surplus