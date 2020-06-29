/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten
	name = "\improper T20mm Tungsten Carbine"
	desc = "Shoots movable rods."
	desc_extended = "A special NanoTrasen Research Team tungesten shooting carbine designed to rival the syndicate energy crossbow. This version shoots tungesten rods instead of energy bolts, is more cumbersome than the energy now, and honestly really doesn't have any resemblence the energy crossbow at all."
	icon = 'icons/obj/item/weapons/ranged/smg/tungsten.dmi'
	icon_state = "inventory"
	shoot_delay = 2
	view_punch = 4
	shoot_sounds = list('sound/weapons/223/shoot.ogg')

	heat_per_shot = 0.01
	heat_max = 0.03

	bullet_length_min = 15
	bullet_length_best = 20
	bullet_length_max = 25

	bullet_diameter_min = 4
	bullet_diameter_best = 5
	bullet_diameter_max = 6

	automatic = FALSE

	override_icon_state = TRUE

	size = SIZE_3
	weight = WEIGHT_4

	value = 100

	ai_heat_sensitivity = 1.5

/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten/update_icon()

	icon_state = initial(icon_state)

	if(stored_magazine)
		icon_state = "[icon_state]_[CEILING((length(stored_magazine.stored_bullets)/stored_magazine.bullet_count_max)*5, 1)]"

	return ..()

/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.025 - (0.05 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten/get_cock_sound(var/direction="both")
	return 'sound/weapons/gun/smg/smg_rack.ogg'