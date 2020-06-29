/obj/item/weapon/ranged/bullet/magazine/rifle/civ_carbine
	name = "\improper 5.56mm BP-SOL"
	desc = "A taste of SOL weaponry."
	desc_extended = "An older version of a carbine. Despite its age, many PMCs consider this carbine superior as it doesn't have any firerate limiters, allowing it to fire 600 rounds per second."
	icon = 'icons/obj/items/weapons/ranged/rifle/556_carbine.dmi'
	icon_state = "inventory"
	value = 150

	shoot_delay = 1

	automatic = TRUE

	shoot_sounds = list('sound/weapons/223/shoot_alt.ogg')

	can_wield = FALSE

	view_punch = 10

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_3
	weight = WEIGHT_4

	heat_per_shot = 0.04
	heat_max = 0.08

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ai_heat_sensitivity = 0.5

/obj/item/weapon/ranged/bullet/magazine/rifle/civ_carbine/get_static_spread() //Base spread
	return 0.02

/obj/item/weapon/ranged/bullet/magazine/rifle/civ_carbine/get_skill_spread(var/mob/living/L) //Base spread
	if(!heat_current)
		return 0
	return max(0,0.02 - (0.06 * L.get_skill_power(SKILL_RANGED)))