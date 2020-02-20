/obj/item/weapon/ranged/bullet/magazine/smg/bullpup
	name = ".45 bullpup submachine gun"
	bullet_type = ".45"
	icon = 'icons/obj/items/weapons/ranged/smg/45.dmi'
	icon_state = "inventory"

	projectile_speed = 20
	shoot_delay = 3

	automatic = TRUE

	bullet_count_max = 1 //One in the chamber



	shoot_sounds = list('sounds/weapons/smg_light/smg.ogg')

	can_wield = FALSE

	override_icon_state = TRUE

	view_punch = 6

	slowdown_mul_held = HELD_SLOWDOWN_SMG

	size = SIZE_3
	weight = WEIGHT_3

	heat_per_shot = 0.04
	heat_max = 0.4

/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		icon_state = "[initial(icon_state)]_[round(length(M.stored_bullets),4)]"
	else
		icon_state = initial(icon_state)

	..()

/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/get_static_spread() //Base spread
	return 0.03

/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/get_skill_spread(var/mob/living/L) //Base spread
	return 0.02 - (0.02 * L.get_skill_power(SKILL_RANGED))