/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper
	name = "\improper .50 BFR Sniper"
	desc = "For when you want to leave a hole the size of a basketball somewhere."
	desc_extended = "The 50 BFR is technically an Anti-Materiel Rifle, but somehow it works against Personnel just as well."
	icon = 'icons/obj/item/weapons/ranged/rifle/syndicate/50.dmi'
	icon_state = "inventory"
	value = 5000

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 20

	damage_mod = 2

	automatic = FALSE

	shoot_sounds = list('sound/weapons/sniper_heavy/heavy_sniper.ogg')

	can_wield = TRUE
	wield_only = TRUE

	heat_max = 0.05

	bullet_length_min = 90
	bullet_length_best = 99
	bullet_length_max = 100

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	size = SIZE_5
	weight = 30

	ai_heat_sensitivity = 2

	zoom_mul = 2

	attachment_whitelist = list()

	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 2
	movement_spread_base = 0.2

/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))