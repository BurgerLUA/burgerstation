/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs
	name = "\improper SRS99 sniper rifle"
	desc = "For when you want to leave a hole the size of a basketball somewhere."
	desc_extended = "Special Applications Rifle, system 99 Anti-Matériel. Deadly at extreme range.  Takes 14.5mm calibre magazines."
	icon = 'icons/obj/item/weapons/ranged/rifle/halo/srs.dmi'


	projectile_speed = TILE_SIZE - 1
	shoot_delay = 20

	automatic = FALSE

	shoot_sounds = list(
	'sound/weapons/unsc/srs/sniper_fire_h3_1.wav',
	'sound/weapons/unsc/srs/sniper_fire_h3_2.wav',
	'sound/weapons/unsc/srs/sniper_fire_h3_3.wav',
	'sound/weapons/unsc/srs/sniper_fire_h3_4.wav')

	can_wield = TRUE
	wield_only = TRUE

	view_punch = TILE_SIZE - 1



	heat_per_shot = 0.1
	heat_max = 0.2

	bullet_length_min = 90
	bullet_length_best = 99
	bullet_length_max = 100

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	size = SIZE_4
	weight = 30


	value = 1500

	ai_heat_sensitivity = 2

	inaccuracy_modifer = 0.1

	zoom_mul = 2

	attachment_whitelist = list()

	firing_pin = /obj/item/firing_pin/electronic/iff/nanotrasen

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper/get_bullet_inaccuracy(var/mob/living/L,var/atom/target,var/obj/projectile/P,var/inaccuracy_modifier)

	var/distance = get_dist(L,target)

	if(distance <= 3)
		return TILE_SIZE*0.5 //No using snipers at close range.

	if(distance <= VIEW_RANGE*0.5)
		return max(0,1 - L.get_skill_power(SKILL_PRECISION)) * ((VIEW_RANGE*0.5)/get_dist(L,target)) * TILE_SIZE*0.5

	return max(0,1 - L.get_skill_power(SKILL_PRECISION))*(0.1+0.9*(get_dist(L,target) - VIEW_RANGE*0.5)) * (L.client && L.client.is_zoomed ? 0.25 : 1)

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs/insurrection
	name = "\improper SRS90 Mercenary rifle"
	desc = "For when you want to leave a hole the size of a basketball somewhere."
	desc_extended = "Special Applications Rifle, system 99 Anti-Matériel. Deadly at extreme range.  Takes 14.5mm calibre magazines. Made from SRS99 by Insurrection engineers."
	icon = 'icons/obj/item/weapons/ranged/rifle/halo/srs_i.dmi'

	shoot_delay = 15
	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs/insurrection/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs/insurrection/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.003 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs/insurrection/get_bullet_inaccuracy(var/mob/living/L,var/atom/target,var/obj/projectile/P,var/inaccuracy_modifier)

	var/distance = get_dist(L,target)

	if(distance <= 3)
		return TILE_SIZE*0.5 //No using snipers at close range.

	if(distance <= VIEW_RANGE*0.5)
		return max(0,1 - L.get_skill_power(SKILL_PRECISION)) * ((VIEW_RANGE*0.5)/get_dist(L,target)) * TILE_SIZE*0.5

	return max(0,1 - L.get_skill_power(SKILL_PRECISION))*(0.1+0.9*(get_dist(L,target) - VIEW_RANGE*0.5)) * (L.client && L.client.is_zoomed ? 0.25 : 1)