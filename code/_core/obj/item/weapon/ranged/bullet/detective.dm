/obj/item/weapon/ranged/bullet/revolver/detective
	name = "\improper .38 revolver"
	desc = "The detective's trusty sidearm. Uses .38 revolver rounds."
	icon = 'icons/obj/items/weapons/ranged/revolver.dmi'
	icon_state = "inventory"

	bullet_speed = 31
	shoot_delay = 5

	automatic = FALSE

	bullet_capacity = 6

	bullet_type = ".38"

	shoot_sounds = list('sounds/weapons/revolver_light/revolver.ogg')

/obj/item/weapon/ranged/bullet/revolver/detective/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/revolver/detective/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED,0,100))