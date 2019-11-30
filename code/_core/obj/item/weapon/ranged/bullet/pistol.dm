/obj/item/weapon/ranged/bullet/magazine/pistol
	name = "10mm Stechkin pistol"
	icon = 'icons/obj/items/weapons/ranged/pistol.dmi'
	icon_state = "inventory"

	bullet_speed = 20
	shoot_delay = 2

	automatic = FALSE

	bullet_count_max = 1 //One in the chamber

	bullet_type = "10mm_auto"

	shoot_sounds = list('sounds/weapons/pistol/shoot.ogg')

	can_wield = FALSE

	override_icon_state = TRUE

	view_punch = 6

	cock_sound = 'sounds/weapons/gun_slide1.ogg'

/obj/item/weapon/ranged/bullet/magazine/pistol/update_icon()

	icon_state = initial(icon_state)

	if(!chambered_bullet)
		icon_state = "[icon_state]_unloaded"

	if(!stored_magazine)
		icon_state = "[icon_state]_open"

	return ..()

/obj/item/weapon/ranged/bullet/magazine/pistol/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/pistol/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))

/obj/item/weapon/ranged/bullet/magazine/pistol/gold_eagle
	name = ".50AE gold eagle"
	icon = 'icons/obj/items/weapons/ranged/deagle.dmi'
	bullet_speed = 28
	shoot_delay = 4
	bullet_type = ".50ae"
	shoot_sounds = list('sounds/weapons/deagle/shoot.ogg')

	view_punch = 12

/obj/item/weapon/ranged/bullet/magazine/pistol/secpistol
	name = ".45 private security pistol"
	icon = 'icons/obj/items/weapons/ranged/45pistol.dmi'
	bullet_speed = 28
	shoot_delay = 4
	bullet_type = ".45"
	shoot_sounds = list('sounds/weapons/pistol_medium/shoot.ogg')

	view_punch = 8

	automatic = FALSE


/obj/item/weapon/ranged/bullet/magazine/pistol/secpistol/special
	name = ".45 tactical pistol"
	icon = 'icons/obj/items/weapons/ranged/45pistol2.dmi'
	shoot_delay = 2
	bullet_type = ".45"
	shoot_sounds = list('sounds/weapons/pistol_medium/shoot.ogg')

	view_punch = 6


/*
/obj/item/weapon/ranged/bullet/magazine/pistol/secpistol/shoot(var/atom/caller,var/atom/object,location,params,var/damage_multiplier=1)

	. = ..()

	if(. && automatic)
		spawn( (next_shoot_time - curtime) + 1)
			if(is_advanced(caller))
				var/mob/living/advanced/A = caller
				world.log << "[A.attack_flags]"
				if( (A.right_item = src && A.attack_flags & ATTACK_HELD_RIGHT) || (A.left_item = src && A.attack_flags & ATTACK_HELD_LEFT))
					shoot(caller,object,location,params,damage_multiplier)

	return .
*/