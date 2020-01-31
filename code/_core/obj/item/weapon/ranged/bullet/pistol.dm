/obj/item/weapon/ranged/bullet/magazine/pistol
	name = "10mm Stechkin pistol"
	icon = 'icons/obj/items/weapons/ranged/pistol.dmi'
	icon_state = "inventory"

	shoot_delay = 2

	automatic = FALSE

	bullet_count_max = 1 //One in the chamber

	bullet_type = "10mm_auto"

	shoot_sounds = list('sounds/weapons/pistol/shoot.ogg')

	can_wield = FALSE

	override_icon_state = TRUE

	view_punch = 8

	cock_sound = 'sounds/weapons/gun_slide1.ogg'

	slowdown_mul_held = HELD_SLOWDOWN_PISTOL

	size = SIZE_1
	weight = WEIGHT_2

	heat_per_shot = 0.05
	heat_current = 0
	heat_max = 0.2

/obj/item/weapon/ranged/bullet/magazine/pistol/update_icon()

	icon_state = initial(icon_state)

	if(!chambered_bullet)
		icon_state = "[icon_state]_unloaded"

	if(!stored_magazine)
		icon_state = "[icon_state]_open"

	return ..()

/obj/item/weapon/ranged/bullet/magazine/pistol/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/pistol/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))

/obj/item/weapon/ranged/bullet/magazine/pistol/deagle
	name = ".50AE deagle"
	icon = 'icons/obj/items/weapons/ranged/deagle.dmi'
	projectile_speed = 28
	shoot_delay = 4
	bullet_type = ".50ae"
	shoot_sounds = list('sounds/weapons/deagle/shoot.ogg')

	view_punch = 12

	size = SIZE_2
	weight = WEIGHT_3

/obj/item/weapon/ranged/bullet/magazine/pistol/deagle/gold
	name = ".50AE gold deagle"
	icon = 'icons/obj/items/weapons/ranged/deagle_gold.dmi'
	projectile_speed = 28
	shoot_delay = 4
	bullet_type = ".50ae"
	shoot_sounds = list('sounds/weapons/deagle/shoot.ogg')

	view_punch = 12

	size = SIZE_2
	weight = WEIGHT_3

/obj/item/weapon/ranged/bullet/magazine/pistol/secpistol
	name = ".45 security pistol"
	icon = 'icons/obj/items/weapons/ranged/45pistol.dmi'
	projectile_speed = 28
	shoot_delay = 4
	bullet_type = ".45"
	shoot_sounds = list('sounds/weapons/pistol_medium/shoot.ogg')

	view_punch = 8

	automatic = FALSE

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/weapon/ranged/bullet/magazine/pistol/secpistol/special
	name = ".45 military pistol"
	icon = 'icons/obj/items/weapons/ranged/45pistol2.dmi'
	shoot_delay = 2
	bullet_type = ".45"
	shoot_sounds = list('sounds/weapons/pistol_medium/shoot.ogg')

	view_punch = 6

	size = SIZE_2
	weight = WEIGHT_2


/obj/item/weapon/ranged/bullet/magazine/pistol/mercenary
	name = ".357 mercenary pistol"
	icon = 'icons/obj/items/weapons/ranged/357pistol.dmi'
	shoot_delay = 4
	bullet_type = ".45"
	shoot_sounds = list('sounds/weapons/pistol_medium/shoot.ogg')

	view_punch = 8

	automatic = FALSE

	size = SIZE_2
	weight = WEIGHT_2

/obj/item/weapon/ranged/bullet/magazine/pistol/mercenary_modified
	name = "9mm modified mercenary pistol"
	icon = 'icons/obj/items/weapons/ranged/9mm_pistol.dmi'
	desc_extended = "A modified variant of the .357 mercenary pistol. The barrel has been refitted to 9mm, the slider shortened, the frame replaced with lighter materials, and a recoil compensator added for extra accuracy."
	shoot_delay = 2
	bullet_type = "9mm"
	shoot_sounds = list('sounds/weapons/pistol_medium/shoot.ogg')

	view_punch = 2

	automatic = FALSE

	size = SIZE_2
	weight = WEIGHT_1

/obj/item/weapon/ranged/bullet/magazine/pistol/mercenary_modified/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/pistol/mercenary_modified/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))

/obj/item/weapon/ranged/bullet/magazine/pistol/mercenary_modified/get_heat_spread()
	return ..() * 0.5

/obj/item/weapon/ranged/bullet/magazine/pistol/silenced
	name = "8mm silenced pistol"
	icon = 'icons/obj/items/weapons/ranged/8mmpistol.dmi'
	projectile_speed = 16
	shoot_delay = 4
	bullet_type = ".45"
	shoot_sounds = list('sounds/weapons/silenced/fire.ogg')

	view_punch = 8

	automatic = FALSE

	size = SIZE_2
	weight = WEIGHT_2