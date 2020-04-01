/obj/item/weapon/ranged/bullet/pump/shotgun/lever
	name = "12g lever-action shotgun"
	desc = "A lever action shotgun."
	icon = 'icons/obj/items/weapons/ranged/shotgun/lever_action.dmi'
	icon_state = "inventory"

	shoot_delay = 3

	automatic = FALSE

	bullet_count_max = 4

	shoot_sounds = list('sounds/weapons/combat_shotgun/shoot.ogg')

	view_punch = 18

	slowdown_mul_held = HELD_SLOWDOWN_SHOTGUN_SMALL

	size = SIZE_3
	weight = WEIGHT_3

	value = 120

	action_name = "work"

/obj/item/weapon/ranged/bullet/pump/shotgun/lever/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/bullet/pump/shotgun/lever/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))