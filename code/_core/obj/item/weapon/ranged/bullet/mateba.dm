/obj/item/weapon/ranged/bullet/revolver/mateba
	name = "\improper .44 Mateba semi-automatic revolver"
	desc = "Semi-automatic!"
	icon = 'icons/obj/items/weapons/ranged/mateba.dmi'
	icon_state = "inventory"

	projectile = /obj/projectile/bullet/revolver_44/

	bullet_speed = 20
	shoot_delay = 3

	automatic = FALSE

	bullet_capacity = 7

	bullet_type = ".44"

	view_punch = 10

	shoot_sounds = list('sounds/weapons/revolver_heavy/shoot.ogg')

/obj/item/weapon/ranged/bullet/revolver/detective/get_static_spread() //Base spread
	return 0.05

/obj/item/weapon/ranged/bullet/revolver/detective/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED))