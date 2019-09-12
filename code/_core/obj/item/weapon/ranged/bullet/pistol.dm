/obj/item/weapon/ranged/bullet/magazine/pistol
	name = "10mm Stechkin pistol"
	icon = 'icons/obj/items/weapons/ranged/pistol.dmi'
	icon_state = "inventory"

	bullet_speed = 20
	shoot_delay = 1.5

	automatic = FALSE

	bullet_capacity = 1 //One in the chamber

	bullet_type = "10mm_auto"

	shoot_sounds = list('sounds/weapons/pistol/shoot.ogg')

	can_wield = FALSE

	override_icon_state = TRUE

	view_punch = 6

/obj/item/weapon/ranged/bullet/magazine/pistol/update_icon()

	icon_state = initial(icon_state)

	if(!length(stored_bullets))
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
	shoot_delay = 3
	bullet_type = ".45"
	shoot_sounds = list('sounds/weapons/pistol_medium/shoot.ogg')

	view_punch = 8
