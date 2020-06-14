/obj/item/weapon/ranged/bullet/pump/shotgun/wood
	name = "12g Civilian Shotgun"
	desc = "A classic pump action shotgun with the stock and barrel shortened."
	icon = 'icons/obj/items/weapons/ranged/shotgun/regular.dmi'
	icon_state = "inventory"

	shoot_delay = 3

	automatic = FALSE

	bullet_count_max = 4

	shoot_sounds = list('sounds/weapons/combat_shotgun/shoot.ogg')

	view_punch = 12

	slowdown_mul_held = HELD_SLOWDOWN_SHOTGUN_SMALL

	size = SIZE_4
	weight = WEIGHT_3

	value = 80

	heat_per_shot = 0.1
	heat_max = 0.3

/obj/item/weapon/ranged/bullet/pump/shotgun/wood/get_base_spread()
	return 0.015

/obj/item/weapon/ranged/bullet/pump/shotgun/wood/get_static_spread() //Base spread
	return 0.002

/obj/item/weapon/ranged/bullet/pump/shotgun/wood/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.025 - (0.01 * L.get_skill_power(SKILL_RANGED)))