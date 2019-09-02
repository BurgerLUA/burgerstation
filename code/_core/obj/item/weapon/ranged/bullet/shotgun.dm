/obj/item/weapon/ranged/bullet/revolver/dbarrel
	name = "\improper 12 gauge boomstick"
	desc = "The bartender's trusty double barrel shotgun. It was cut in half by a clown."
	icon = 'icons/obj/items/weapons/ranged/dbarrel.dmi'
	icon_state = "inventory"

	bullet_speed = 16
	shoot_delay = 2

	automatic = FALSE

	bullet_capacity = 2

	bullet_type = "shotgun"

	insert_limit = 2

	view_punch = 12

	//shoot_sounds = list('sounds/weapons/pumpshotgun/shoot.ogg')

/obj/item/weapon/ranged/bullet/revolver/dbarrel/get_static_spread() //Base spread
	return 0.2

/obj/item/weapon/ranged/bullet/revolver/dbarrel/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED,0,100))