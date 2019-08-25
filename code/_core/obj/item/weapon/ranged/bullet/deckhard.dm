/obj/item/weapon/ranged/bullet/revolver/deckhard
	name = "\improper .22 space police revolver"
	desc = "A sidearm commonly used by space police. Uses .22 LR rounds."
	icon = 'icons/obj/items/weapons/ranged/deckhard_mine.dmi'
	icon_state = "inventory"

	bullet_speed = 31
	shoot_delay = 2

	automatic = TRUE

	bullet_capacity = 6

	bullet_type = ".22"

	shoot_sounds = list('sounds/weapons/deckhard/shot.ogg')

	view_punch = 2

/obj/item/weapon/ranged/bullet/revolver/deckhard/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/revolver/deckhard/get_skill_spread(var/mob/living/L) //Base spread
	return 0.02 - (0.02 * L.get_skill_power(SKILL_RANGED,0,100))