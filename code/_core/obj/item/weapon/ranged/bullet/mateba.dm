/obj/item/weapon/ranged/bullet/revolver/mateba
	name = "\improper .44 Mateba"
	desc = "Semi-automatic!"
	icon = 'icons/obj/items/weapons/ranged/mateba.dmi'
	icon_state = "inventory"

	projectile = /obj/projectile/bullet/revolver_44/
	ranged_damage_type = /damagetype/ranged/revolver_44
	damage_type = /damagetype/blunt/pistol

	bullet_speed = 31
	shoot_delay = 2

	automatic = FALSE

	bullet_capacity = 7

	bullet_type = ".44"

	shoot_sounds = list('sounds/weapon/ranged/bullet/heavy_revolver.ogg')

/obj/item/weapon/ranged/bullet/revolver/detective/get_static_spread() //Base spread
	return 0.05

/obj/item/weapon/ranged/bullet/revolver/detective/get_skill_spread(var/mob/living/L) //Base spread
	return 0.2 - (0.2 * L.get_skill_power(SKILL_RANGED,0,100))