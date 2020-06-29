/obj/item/weapon/ranged/bullet/magazine/smg/pdw
	name = "\improper 4.6x30mm WT-550"
	desc = "Something squeaks that isn't supposed to squeak? Put some WT-500 on it."
	desc_extended = "A NanoTrasen made and used personal defense weapon designed for security forces on stations. The unique 4.6x30mm ammo type offers a robust array of special rounds for all combat situations."
	icon = 'icons/obj/items/weapons/ranged/smg/4mm.dmi'
	icon_state = "inventory"

	automatic = TRUE
	can_wield = FALSE

	shoot_delay = 1
	max_bursts = 5
	view_punch = 4

	shoot_sounds = list('sound/weapons/smg_light/smg.ogg')

	override_icon_state = TRUE

	heat_per_shot = 0.03
	heat_max = 0.09

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

	size = SIZE_3
	weight = WEIGHT_3

	value = 110

	ai_heat_sensitivity = 0.5

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		icon_state = "[initial(icon_state)]_[CEILING( (length(M.stored_bullets)/20)*5,1)]"
	else
		icon_state = "[initial(icon_state)]_open"
	..()