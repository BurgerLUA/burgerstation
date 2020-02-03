/obj/item/weapon/ranged/bullet/magazine/smg/pdw
	name = "\improper .25 PDW"
	icon = 'icons/obj/items/weapons/ranged/smg/25.dmi'
	icon_state = "inventory"

	automatic = TRUE
	can_wield = FALSE

	shoot_delay = 1
	max_bursts = 5
	view_punch = 4

	bullet_count_max = 1 //One in the chamber
	bullet_type = ".25"

	shoot_sounds = list('sounds/weapons/smg_light/smg.ogg')

	override_icon_state = TRUE



/obj/item/weapon/ranged/bullet/magazine/smg/pdw/get_static_spread() //Base spread
	return 0.1

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))