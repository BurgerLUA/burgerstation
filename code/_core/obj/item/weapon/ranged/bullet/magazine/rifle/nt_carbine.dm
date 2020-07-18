/obj/item/weapon/ranged/bullet/magazine/rifle/nt_carbine
	name = "\improper 5.56 U-NT Carabiner"
	desc = "Good for shuttle hijackings."
	desc_extended = "A small carbine rifle that was intended to phase out the much older AR-SS13. Turns out, people still like the AR-SS13 for what it does, so it exists alongside it."
	icon = 'icons/obj/item/weapons/ranged/rifle/556_nt_carbine.dmi'
	icon_state = "inventory"
	value = 150

	shoot_delay = 1.5

	automatic = TRUE

	shoot_sounds = list('sound/weapons/223/shoot_alt.ogg')

	can_wield = FALSE

	view_punch = 10

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_3


	heat_per_shot = 0.04
	heat_max = 0.08

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ai_heat_sensitivity = 0.5

/obj/item/weapon/ranged/bullet/magazine/rifle/nt_carbine/get_static_spread() //Base spread
	return 0.02

/obj/item/weapon/ranged/bullet/magazine/rifle/nt_carbine/get_skill_spread(var/mob/living/L) //Base spread
	if(!heat_current)
		return 0
	return max(0,0.02 - (0.06 * L.get_skill_power(SKILL_RANGED)))