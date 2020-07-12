/obj/item/weapon/ranged/bullet/magazine/rifle/service
	name = "\improper 7.62mm SOL-14"
	desc = "HOORAH!."
	desc_extended = "The SOL-14 is the battle rifle currently in service in the SolGov Army. It's occasionally seen in the hands of PMCs."
	icon = 'icons/obj/item/weapons/ranged/rifle/762_service.dmi'
	icon_state = "inventory"
	value = 300

	shoot_delay = 3

	automatic = FALSE

	shoot_sounds = list('sound/weapons/308/shoot.ogg')

	can_wield = TRUE

	view_punch = 8

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4

	heat_per_shot = 0.01
	heat_max = 0.08

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	ai_heat_sensitivity = 1.5

/obj/item/weapon/ranged/bullet/magazine/rifle/service/get_static_spread() //Base spread
	if(!wielded)
		return 0.2
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/service/get_skill_spread(var/mob/living/L) //Base spread
	if(!heat_current)
		return 0
	return max(0,0.02 - (0.06 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/magazine/rifle/service/nt
	dan_mode = TRUE
	icon = 'icons/obj/item/weapons/ranged/rifle/762_service_nt.dmi'