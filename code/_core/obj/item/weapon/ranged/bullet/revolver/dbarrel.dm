/obj/item/weapon/ranged/bullet/revolver/dbarrel
	name = "\improper 12 gauge boomstick"
	desc = "The bartender's trusty double barrel shotgun. It was cut in half by a clown."
	desc_extended = "Double barreled shotguns are often sawed off in order to be used as a sidearm, at the cost of the user's wrist bones."
	icon = 'icons/obj/item/weapons/ranged/dbarrel.dmi'
	icon_state = "inventory"

	shoot_delay = 2

	automatic = FALSE

	bullet_count_max = 2

	insert_limit = 2

	view_punch = 12

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	slowdown_mul_held = HELD_SLOWDOWN_SHOTGUN_SMALL

	size = SIZE_2


	bullet_length_min = 18
	bullet_length_best = 18.5
	bullet_length_max = 19

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19

	heat_per_shot = 0.05
	heat_max = 0.1

	value = 60

	inaccuracy_modifer = 1

/obj/item/weapon/ranged/bullet/revolver/dbarrel/get_base_spread()
	return 0.1

/obj/item/weapon/ranged/bullet/revolver/dbarrel/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/bullet/revolver/dbarrel/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.03 - (0.12 * L.get_skill_power(SKILL_RANGED)))