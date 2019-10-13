/obj/item/weapon/ranged/bullet/magazine/lmg
	name = "\improper 5.56mm large machinegun"
	icon = 'icons/obj/items/weapons/ranged/lmg.dmi'
	icon_state = "inventory"

	bullet_speed = 26
	shoot_delay = 3

	automatic = TRUE

	bullet_count_max = 1 //One in the chamber

	bullet_type = "5.56"

	shoot_sounds = list('sounds/weapons/assault_rifle/assault_rifle.ogg')

	can_wield = TRUE

	override_icon_state = TRUE

	override_icon_state_held = TRUE

	view_punch = 4


/obj/item/weapon/ranged/bullet/magazine/lmg/update_icon()

	var/modifier = "[wielded ? "_wielded" : ""][open ? "_open" : ""][stored_magazine ? "_1" : ""]"

	icon_state_held_right = "held_right[modifier]"
	icon_state_held_left = "held_left[modifier]"

	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		icon_state = "[initial(icon_state)][open ? "_open" : ""]_[round(length(M.stored_bullets),10)]"
	else
		icon_state = "[initial(icon_state)][open ? "_open" : ""]"

	update_held_icon()

	return ..()

/obj/item/weapon/ranged/bullet/magazine/lmg/get_static_spread() //Base spread
	if(!wielded)
		return 0.2
	return 0

/obj/item/weapon/ranged/bullet/magazine/lmg/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))