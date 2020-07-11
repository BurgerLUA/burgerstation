/obj/item/weapon/ranged/bullet/pump/shotgun/lever
	name = "12g lever-action shotgun"
	desc = "Git off my property!"
	desc_extended = "A lever action shotgun. Its lightweight, long-barrel design makes it more accurate than most shotguns, but fires slower. The weapon of choice for Space Farmers."
	icon = 'icons/obj/item/weapons/ranged/shotgun/lever_action.dmi'
	icon_state = "inventory"

	shoot_delay = 7

	automatic = FALSE

	bullet_count_max = 4

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	view_punch = 18

	slowdown_mul_held = HELD_SLOWDOWN_SHOTGUN_SMALL

	size = SIZE_4


	value = 120

	action_name = "work"

	heat_per_shot = 0.03
	heat_max = 0.12

/obj/item/weapon/ranged/bullet/pump/shotgun/lever/get_base_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/pump/shotgun/lever/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/pump/shotgun/lever/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))