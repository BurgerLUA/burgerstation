/obj/item/weapon/ranged/bullet/magazine/rifle/standard
	name = "\improper 5.56 AR-SS13"
	desc = "Vanilla yet still advanced."
	desc_extended = "A cheap yet still reliable assault rifle primarily used and mass produced by NanoTrasen PMCs. Kicks like a mule, though."
	icon = 'icons/obj/item/weapons/ranged/rifle/556_nt.dmi'
	icon_state = "inventory"
	value = 200

	shoot_delay = 2

	automatic = TRUE

	shoot_sounds = list('sound/weapons/223/shoot.ogg')

	can_wield = TRUE

	view_punch = 10

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
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


/obj/item/weapon/ranged/bullet/magazine/rifle/standard/get_static_spread() //Base spread
	if(!wielded)
		return 0.15
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/standard/get_skill_spread(var/mob/living/L) //Base spread
	if(!heat_current)
		return 0
	return max(0,0.03 - (0.06 * L.get_skill_power(SKILL_RANGED)))