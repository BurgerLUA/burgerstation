/obj/item/weapon/ranged/bullet/revolver/dbarrel
	name = "\improper double barrel shotgun"
	desc = "The bartender's trusty double barrel shotgun"
	icon = 'icons/obj/items/weapons/ranged/dbarrel.dmi'
	icon_state = "inventory"

	projectile = /obj/projectile/bullet/shotgun/
	ranged_damage_type = /damagetype/ranged/shotgun
	damage_type = /damagetype/sword/

	bullet_speed = 16
	bullet_count = 8
	shoot_delay = 2

	automatic = FALSE

	bullet_capacity = 2

	bullet_type = "shotgun"

	insert_limit = 2

	shoot_sounds = list('sounds/weapon/ranged/bullet/doublebarrel_shotgun.ogg')


/obj/item/weapon/ranged/bullet/revolver/dbarrel/get_static_spread() //Base spread
	return 0.2

/obj/item/weapon/ranged/bullet/revolver/dbarrel/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED,0,100))