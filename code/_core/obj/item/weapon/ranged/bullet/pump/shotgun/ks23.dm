/obj/item/weapon/ranged/bullet/pump/shotgun/ks23
	name = "23x75mmR KS23 Shotgun"
	desc = "Technically a Carbine!"
	desc_extended = "A russian shotgun with a rifled barrel and a 23mm bore."
	icon = 'icons/obj/item/weapons/ranged/shotgun/ks23.dmi'
	icon_state = "inventory"

	can_wield = TRUE

	dan_mode = TRUE

	shoot_delay = 3

	automatic = FALSE

	bullet_count_max = 3

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')


	bullet_length_min = 73
	bullet_length_best = 75
	bullet_length_max = 78

	bullet_diameter_min = 21
	bullet_diameter_best = 23
	bullet_diameter_max = 25

	view_punch = 16

	slowdown_mul_held = HELD_SLOWDOWN_SHOTGUN_SMALL

	size = SIZE_4


	value = 80

	heat_per_shot = 0.09
	heat_max = 0.18

/obj/item/weapon/ranged/bullet/pump/shotgun/ks23/get_base_spread()
	return 0.12

/obj/item/weapon/ranged/bullet/pump/shotgun/ks23/get_static_spread() //Base spread
	return 0.004

/obj/item/weapon/ranged/bullet/pump/shotgun/ks23/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.025 - (0.01 * L.get_skill_power(SKILL_RANGED)))