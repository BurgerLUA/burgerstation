/obj/item/magazine/rifle_223
	name = "\improper .223 magazine"
	icon = 'icons/obj/items/magazine/223_rifle.dmi'
	icon_state = "223"
	bullet_count_max = 30

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/rifle,
	)

	ammo = /obj/item/bullet_cartridge/rifle_223

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

/obj/item/magazine/rifle_223/update_icon()
	if(length(stored_bullets))
		icon_state = "[initial(icon_state)]_1"
	else
		icon_state = "[initial(icon_state)]"

	..()
/*
/obj/item/magazine/rifle_223/surplus
	name = "\improper surplus .223 magazine"
	ammo = /obj/item/bullet_cartridge/rifle_223/surplus
*/