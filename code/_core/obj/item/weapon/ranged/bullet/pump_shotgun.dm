/obj/item/weapon/ranged/bullet/pump/pump_shotgun
	name = "12 gauge pump shotgun"
	desc = "A classic pump action shotgun with the stock and barrel shortened."
	icon = 'icons/obj/items/weapons/ranged/basic_shotgun.dmi'
	icon_state = "inventory"

	shoot_delay = 4

	automatic = FALSE

	bullet_count_max = 4

	bullet_type = "shotgun"

	shoot_sounds = list('sounds/weapons/combat_shotgun/shoot.ogg')

	view_punch = 12

	slowdown_mul_held = HELD_SLOWDOWN_SHOTGUN_SMALL

/obj/item/weapon/ranged/bullet/pump/pump_shotgun/get_static_spread() //Base spread
	return 0.03

/obj/item/weapon/ranged/bullet/pump/pump_shotgun/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))