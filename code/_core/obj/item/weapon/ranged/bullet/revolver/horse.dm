/obj/item/weapon/ranged/bullet/revolver/horse
	name = "\improper .45 HOL-Horse Revolver"
	desc = "Yeehaw chucklefucks."
	desc_extended = "A replica of a past relic, this double action revolver fires .45 pistol rounds. Not very practical, but at least you'll look cool using it."
	icon = 'icons/obj/item/weapons/ranged/revolver/45.dmi'
	icon_state = "inventory"

	shoot_delay = 1

	automatic = FALSE

	bullet_count_max = 6

	shoot_sounds = list('sound/weapons/revolver_light/revolver.ogg')

	view_punch = 4

	slowdown_mul_held = HELD_SLOWDOWN_REVOLVER

	size = SIZE_1


	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	heat_per_shot = 0.02
	heat_max = 0.1

	value = 400

	open = TRUE //Starts open.

	can_shoot_while_open = TRUE

	inaccuracy_modifer = 0.25

/obj/item/weapon/ranged/bullet/revolver/horse/get_static_spread() //Base spread
	return 0.002

/obj/item/weapon/ranged/bullet/revolver/horse/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.03 - (0.06 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/revolver/horse/click_self(var/mob/caller)
	rotate_cylinder(-1)
	caller?.to_chat(span("notice","You rotate the cylinder backwards."))
	return TRUE