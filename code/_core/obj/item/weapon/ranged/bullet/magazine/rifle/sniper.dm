/obj/item/weapon/ranged/bullet/magazine/rifle/sniper
	name = "\improper 7.62mm Dragon Sniper Rifle"
	desc = "For when you want to be an asshole at an extended range."
	desc_extended = "The Dragon Sniper Rifle is a versatile option as both a Squad Support weapon and an assassination weapon, but suffers against more heavily armored targets."
	icon = 'icons/obj/item/weapons/ranged/rifle/762.dmi'
	icon_state = "inventory"

	shoot_delay = 5

	automatic = FALSE

	shoot_sounds = list('sound/weapons/rifle_heavy/shoot.ogg')

	can_wield = TRUE
	wield_only = TRUE

	view_punch = 32



	size = SIZE_5
	weight = 20


	heat_per_shot = 0.07
	heat_max = 0.07

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_4


	value = 400

	ai_heat_sensitivity = 2

	zoom_mul = 2

	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.004 - (0.004 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/magazine/rifle/sniper/get_bullet_inaccuracy(var/mob/living/L,var/atom/target,var/obj/projectile/P,var/inaccuracy_modifier)

	var/distance = get_dist(L,target)

	if(distance <= 3)
		return TILE_SIZE*0.5 //No using snipers at close range.

	if(distance <= VIEW_RANGE*0.5)
		return max(0,1 - L.get_skill_power(SKILL_PRECISION)) * ((VIEW_RANGE*0.5)/get_dist(L,target)) * TILE_SIZE*0.5

	return max(0,1 - L.get_skill_power(SKILL_PRECISION))*(0.1+0.9*(get_dist(L,target) - VIEW_RANGE*0.5)) * (L.client && L.client.is_zoomed ? 0.25 : 1)