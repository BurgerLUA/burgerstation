/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper
	name = "\improper .50 BFR Sniper"
	desc = "For when you want to be an asshole at an extended range."
	icon = 'icons/obj/items/weapons/ranged/rifle/50.dmi'
	icon_state = "inventory"


	projectile_speed = TILE_SIZE - 1
	shoot_delay = 20

	automatic = FALSE

	shoot_sounds = list('sounds/weapons/sniper_heavy/heavy_sniper.ogg')

	can_wield = TRUE
	wield_only = TRUE

	view_punch = TILE_SIZE - 1

	slowdown_mul_held = HELD_SLOWDOWN_SNIPER_LARGE

	heat_per_shot = 0.1
	heat_max = 0.1

	bullet_length_min = 90
	bullet_length_best = 99
	bullet_length_max = 100

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	size = SIZE_5
	weight = WEIGHT_5

	value = 500

	ai_heat_sensitivity = 2

/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))