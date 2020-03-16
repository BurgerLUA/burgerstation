/obj/item/weapon/ranged/bullet/magazine/smg/pdw
	name = "\improper .22 PDW"
	icon = 'icons/obj/items/weapons/ranged/smg/25.dmi'
	icon_state = "inventory"

	automatic = TRUE
	can_wield = FALSE

	shoot_delay = 1
	max_bursts = 5
	view_punch = 4

	shoot_sounds = list('sounds/weapons/smg_light/smg.ogg')

	override_icon_state = TRUE

	heat_per_shot = 0.01
	heat_max = 0.1

	bullet_length_min = 12
	bullet_length_best = 17.7
	bullet_length_max = 19

	bullet_diameter_min = 5
	bullet_diameter_best = 5.6
	bullet_diameter_max = 6

	size = SIZE_3
	weight = WEIGHT_3

	value = 110

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/get_static_spread() //Base spread
	return 0.04

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		icon_state = "[initial(icon_state)]_[round(length(M.stored_bullets),4)]"
	else
		icon_state = initial(icon_state)

	..()