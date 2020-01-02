/obj/item/magazine/lmg_556
	name = "\improper 5.56mm lmg magazine"
	bullet_type = "5.56"
	icon = 'icons/obj/items/magazine/556lmg.dmi'
	icon_state = "556"
	bullet_count_max = 50

	weapon_whitelist = list(
		/obj/item/weapon/ranged/bullet/magazine/lmg
	)

	ammo = /obj/item/bullet/rifle_556

/obj/item/magazine/lmg_556/update_icon()
	icon_state = "[initial(icon_state)]_[round(length(stored_bullets),10)]"
	..()
