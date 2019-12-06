/obj/item/weapon/ranged/bullet/revolver/traitor_357
	name = "\improper .357 Traditore"
	desc = "For all your traitor needs!"
	icon = 'icons/obj/items/weapons/ranged/357.dmi'
	icon_state = "inventory"

	shoot_delay = 7

	automatic = FALSE

	bullet_count_max = 6

	bullet_type = ".357"

	shoot_sounds = list('sounds/weapons/traitor/fire.ogg')

	view_punch = 12

/obj/item/weapon/ranged/bullet/revolver/traitor_357/get_static_spread() //Base spread
	return 0.01

/obj/item/weapon/ranged/bullet/revolver/traitor_357/get_skill_spread(var/mob/living/L) //Base spread
	return 0.04 - (0.04 * L.get_skill_power(SKILL_RANGED))