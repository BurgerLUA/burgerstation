/obj/item/weapon/ranged/bullet/revolver/mateba
	name = "\improper .44 semi-automatic revolver"
	desc = "Semi-automatic!"
	icon = 'icons/obj/items/weapons/ranged/mateba.dmi'
	icon_state = "inventory"

	bullet_speed = 20
	shoot_delay = 5

	automatic = FALSE

	bullet_count_max = 6

	bullet_type = ".44"

	shoot_sounds = list('sounds/weapons/revolver_heavy/shoot.ogg')

	view_punch = 10

/obj/item/weapon/ranged/bullet/revolver/detective/get_static_spread() //Base spread
	return 0.05

/obj/item/weapon/ranged/bullet/revolver/detective/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))