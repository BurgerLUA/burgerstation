/obj/item/weapon/ranged/bullet/magazine/rifle/lmg
	name = "\improper .223 Defender LMG"
	desc = "Atatatatatatata."
	desc_extended = "The .223 Defender Light Machine Gun is a not very light machine gun meant to fire a lot of rounds in quick succession for relatively extended periods of time. Was designed by syndicate weapon scientists to take 5.56mm rounds that are commonly dropped by the enemy."
	icon = 'icons/obj/item/weapons/ranged/rifle/lmg.dmi'
	icon_state = "inventory"
	value = 200

	shoot_delay = 1.5

	automatic = TRUE

	shoot_sounds = list('sound/weapons/smg_heavy/classic_2.ogg')

	can_wield = TRUE

	override_icon_state = TRUE

	override_icon_state_held = TRUE

	view_punch = 8

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE_LARGE

	heat_per_shot = 0.025
	heat_max = 0.125

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	size = SIZE_4


	value = 400

	ai_heat_sensitivity = 0.25

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg/update_icon()

	var/modifier = "[wielded ? "_wielded" : ""][open ? "_open" : ""][stored_magazine ? "_1" : ""]"

	icon_state_held_right = "held_right[modifier]"
	icon_state_held_left = "held_left[modifier]"

	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		var/math_mod = (length(M.stored_bullets)/M.bullet_count_max)*5
		icon_state = "[initial(icon_state)][open ? "_open" : ""]_[CEILING(math_mod, 1)]"
	else
		icon_state = "[initial(icon_state)][open ? "_open" : ""]"

	update_held_icon()

	return ..()

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg/get_static_spread() //Base spread
	if(!wielded)
		return 0.2
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.01 - (0.15 * L.get_skill_power(SKILL_RANGED)))