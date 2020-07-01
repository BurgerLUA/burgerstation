/obj/item/weapon/ranged/bullet/magazine/smg/wasp
	name = ".22LR Wasp SMG"
	desc = "Wait is that chambered in .22?"
	desc_extended = "A very weak, but easily controllable and concealable SMG."
	icon = 'icons/obj/items/weapons/ranged/cr19.dmi'
	icon_state = "inventory"
	shoot_delay = 2
	view_punch = 2
	shoot_sounds = list('sounds/weapons/smg_light/smg.ogg')

	override_icon_state = TRUE
	automatic = TRUE

	heat_per_shot = 0.01
	heat_max = 0.06

/obj/item/weapon/ranged/bullet/magazine/smg/wasp/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		icon_state = "[initial(icon_state)]_[CEILING(length(M.stored_bullets)/2,4)]"
	else
		icon_state = initial(icon_state)

	..()

/obj/item/weapon/ranged/bullet/magazine/smg/wasp/get_static_spread() //Base spread
	return 0.03

/obj/item/weapon/ranged/bullet/magazine/smg/wasp/get_skill_spread(var/mob/living/L) //Base spread
	return 0.03 - (0.03 * L.get_skill_power(SKILL_RANGED))