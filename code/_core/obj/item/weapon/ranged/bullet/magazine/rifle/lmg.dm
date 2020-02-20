/obj/item/weapon/ranged/bullet/magazine/rifle/lmg
	name = "\improper 5.56mm LMG"
	bullet_type = ".223"
	desc = "Atatatatatatata."
	desc_extended = "The 5.56mm Calibre Light Machine Gun is a not very light machine gun meant to fire a lot of rounds in quick succession for relatively extended periods of time."
	icon = 'icons/obj/items/weapons/ranged/rifle/lmg.dmi'
	icon_state = "inventory"
	value = 200

	shoot_delay = 2

	automatic = TRUE

	bullet_count_max = 1 //One in the chamber



	shoot_sounds = list('sounds/weapons/assault_rifle/assault_rifle.ogg')

	can_wield = TRUE

	override_icon_state = TRUE

	override_icon_state_held = TRUE

	view_punch = 8

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE_LARGE

	size = SIZE_4
	weight = WEIGHT_5

	heat_per_shot = 0.05
	heat_max = 0.3

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg/update_icon()

	var/modifier = "[wielded ? "_wielded" : ""][open ? "_open" : ""][stored_magazine ? "_1" : ""]"

	icon_state_held_right = "held_right[modifier]"
	icon_state_held_left = "held_left[modifier]"

	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		var/math_mod = (length(M.stored_bullets)/M.bullet_count_max)*5
		icon_state = "[initial(icon_state)][open ? "_open" : ""]_[ceiling(math_mod)]"
	else
		icon_state = "[initial(icon_state)][open ? "_open" : ""]"

	update_held_icon()

	return ..()

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg/get_static_spread() //Base spread
	if(!wielded)
		return 0.2
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))