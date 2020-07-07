/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun
	name = "\improper 2x12mm Experimental Gauss Gun"
	desc = "We thank you, oh Monolith, for revealing the cunning plans of your enemies to us. May your light shine down on the souls of the brave soldiers who gave their lives in service to your will."
	desc_extended = "A super-accurate hi-tech weapon known as the Gauss rifle, this weapon was developed in secret laboratories located inside the russian facilities. The weapon operates by accelerating bullets to extremely high speeds using a system of electromagnets, which provides incredible stopping power with virtually no recoil."
	icon = 'icons/obj/item/weapons/ranged/rifle/gauss_gun.dmi'
	icon_state = "inventory"
	value = 1200

	shoot_delay = SECONDS_TO_DECISECONDS(2)

	automatic = FALSE

	shoot_sounds = list('sound/weapons/russia/gauss.ogg')

	can_wield = TRUE
	wield_only = TRUE

	view_punch = 64

	slowdown_mul_held = HELD_SLOWDOWN_SNIPER_LARGE

	size = SIZE_4
	weight = WEIGHT_4

	heat_per_shot = 0.06
	heat_max = 0.06

	bullet_length_min = 11
	bullet_length_best = 12
	bullet_length_max = 13

	bullet_diameter_min = 1.75
	bullet_diameter_best = 2
	bullet_diameter_max = 2.25

	ai_heat_sensitivity = 2

	inaccuracy_modifer = 0.1

	zoom_mul = 2

/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/get_skill_spread(var/mob/living/L) //Base spread
	return max(0.01 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_gun/get_bullet_inaccuracy(var/mob/living/L,var/atom/target,var/obj/projectile/P,var/inaccuracy_modifier)

	var/distance = get_dist(L,target)

	if(distance <= 3)
		return TILE_SIZE*0.5 //No using snipers at close range.

	if(distance <= VIEW_RANGE*0.5)
		return max(0,1 - L.get_skill_power(SKILL_PRECISION)) * ((VIEW_RANGE*0.5)/get_dist(L,target)) * TILE_SIZE*0.5

	return max(0,1 - L.get_skill_power(SKILL_PRECISION))*(0.1+0.9*(get_dist(L,target) - VIEW_RANGE*0.5)) * (L.client && L.client.is_zoomed ? 0.25 : 1)