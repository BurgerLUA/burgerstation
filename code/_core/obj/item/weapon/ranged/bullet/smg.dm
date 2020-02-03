/obj/item/weapon/ranged/bullet/magazine/smg
	name = ".45 bullpup submachine gun"
	icon = 'icons/obj/items/weapons/ranged/smg/45.dmi'
	icon_state = "inventory"

	projectile_speed = 20
	shoot_delay = 3

	automatic = TRUE

	bullet_count_max = 1 //One in the chamber

	bullet_type = ".45"

	shoot_sounds = list('sounds/weapons/smg_light/smg.ogg')

	can_wield = FALSE

	override_icon_state = TRUE

	view_punch = 6

	slowdown_mul_held = HELD_SLOWDOWN_SMG

	size = SIZE_3
	weight = WEIGHT_3

/obj/item/weapon/ranged/bullet/magazine/smg/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		icon_state = "[initial(icon_state)]_[round(length(M.stored_bullets),4)]"
	else
		icon_state = initial(icon_state)

	..()

/obj/item/weapon/ranged/bullet/magazine/smg/get_static_spread() //Base spread
	return 0.1

/obj/item/weapon/ranged/bullet/magazine/smg/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))


/obj/item/weapon/ranged/bullet/magazine/smg/pdw
	name = "\improper .25 PDW"
	icon = 'icons/obj/items/weapons/ranged/smg/25.dmi'
	icon_state = "inventory"

	automatic = TRUE
	can_wield = FALSE

	shoot_delay = 1
	max_bursts = 5
	view_punch = 4

	bullet_count_max = 1 //One in the chamber
	bullet_type = ".25"

	shoot_sounds = list('sounds/weapons/smg_light/smg.ogg')

	override_icon_state = TRUE



/obj/item/weapon/ranged/bullet/magazine/smg/pdw/get_static_spread() //Base spread
	return 0.1

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))


/obj/item/weapon/ranged/bullet/magazine/smg/tactical
	name = "8mm silent syndicate submachine gun"
	icon = 'icons/obj/items/weapons/ranged/smg/8mm.dmi'
	icon_state = "inventory"
	shoot_delay = 3
	view_punch = 4
	shoot_sounds = list('sounds/weapons/silenced/fire.ogg')

/obj/item/weapon/ranged/bullet/magazine/wasp
	name = ".22LR Wasp SMG"
	desc = "Wait is that chambered in .22?"
	icon = 'icons/obj/items/weapons/ranged/cr19.dmi'
	icon_state = "inventory"
	shoot_delay = 2
	view_punch = 2
	shoot_sounds = list('sounds/weapons/smg_light/smg.ogg')

	override_icon_state = TRUE
	automatic = TRUE

/obj/item/weapon/ranged/bullet/magazine/wasp/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		icon_state = "[initial(icon_state)]_[ceiling(length(M.stored_bullets)/2,4)]"
	else
		icon_state = initial(icon_state)

	..()

/obj/item/weapon/ranged/bullet/magazine/wasp/get_static_spread() //Base spread
	return 0.05

/obj/item/weapon/ranged/bullet/magazine/wasp/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))