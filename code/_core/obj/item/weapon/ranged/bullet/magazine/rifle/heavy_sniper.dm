/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper
	name = "\improper .50 BFR Sniper"
	desc = "For when you want to leave a hole the size of a basketball somewhere."
	desc_extended = "The 50 BFR is technically an Anti-Materiel Rifle, but somehow it works against Personnel just as well."
	icon = 'icons/obj/item/weapons/ranged/rifle/50.dmi'
	icon_state = "inventory"


	projectile_speed = TILE_SIZE - 1
	shoot_delay = 30

	automatic = FALSE

	shoot_sounds = list('sound/weapons/sniper_heavy/heavy_sniper.ogg')

	can_wield = TRUE
	wield_only = TRUE

	view_punch = TILE_SIZE - 1



	heat_per_shot = 0.1
	heat_max = 0.1

	bullet_length_min = 90
	bullet_length_best = 99
	bullet_length_max = 100

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	size = SIZE_4
	weight = 30


	value = 500

	ai_heat_sensitivity = 2

	inaccuracy_modifer = 0.1

	zoom_mul = 2

	attachment_whitelist = list()

	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper/get_bullet_inaccuracy(var/mob/living/L,var/atom/target,var/obj/projectile/P,var/inaccuracy_modifier)

	var/distance = get_dist(L,target)

	if(distance <= 3)
		return TILE_SIZE*0.5 //No using snipers at close range.

	if(distance <= VIEW_RANGE*0.5)
		return max(0,1 - L.get_skill_power(SKILL_PRECISION)) * ((VIEW_RANGE*0.5)/get_dist(L,target)) * TILE_SIZE*0.5

	return max(0,1 - L.get_skill_power(SKILL_PRECISION))*(0.1+0.9*(get_dist(L,target) - VIEW_RANGE*0.5)) * (L.client && L.client.is_zoomed ? 0.25 : 1)