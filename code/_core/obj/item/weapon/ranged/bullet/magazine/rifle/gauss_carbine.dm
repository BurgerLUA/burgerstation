/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_carbine
	name = "\improper 2x12mm Gauss Carbine"
	desc = "We thank you, oh Monolith, for revealing the cunning plans of your enemies to us. May your light shine down on the souls of the brave soldiers who gave their lives in service to your will."
	desc_extended = "A super-accurate hi-tech weapon known as the Gauss rifle, this weapon was developed in secret laboratories located inside the russian facilities. The weapon operates by accelerating bullets to extremely high speeds using a system of electromagnets, which provides incredible stopping power with virtually no recoil."
	icon = 'icons/obj/item/weapons/ranged/rifle/gauss_carbine.dmi'
	icon_state = "inventory"
	value = 300

	shoot_delay = 5

	automatic = FALSE

	shoot_sounds = list('sound/weapons/russia/gauss.ogg')

	can_wield = TRUE
	wield_only = TRUE

	view_punch = 16

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4
	weight = WEIGHT_4

	heat_per_shot = 0.12
	heat_max = 0.12

	bullet_length_min = 11
	bullet_length_best = 12
	bullet_length_max = 13

	bullet_diameter_min = 1
	bullet_diameter_best = 2
	bullet_diameter_max = 3

	ai_heat_sensitivity = 1.5

/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_carbine/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/gauss_carbine/get_skill_spread(var/mob/living/L) //Base spread
	return max(0.1 - (0.03 * L.get_skill_power(SKILL_RANGED)))
