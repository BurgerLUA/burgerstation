/obj/item/weapon/ranged/bullet/pump/combat_shotgun
	name = "combat shotgun"
	desc = "A very robust combat shotgun."
	icon = 'icons/obj/items/weapons/ranged/combat_shotgun.dmi'
	icon_state = "inventory"

	projectile = /obj/projectile/bullet/shotgun/
	ranged_damage_type = /damagetype/ranged/shotgun
	damage_type = /damagetype/sword/

	bullet_speed = 16
	bullet_count = 8
	shoot_delay = 1

	automatic = FALSE

	bullet_capacity = 6

	bullet_type = "shotgun"

	shoot_sounds = list('sounds/weapon/ranged/bullet/combat_shotgun.ogg')

	can_wield = TRUE

/obj/item/weapon/ranged/bullet/pump/combat_shotgun/get_static_spread() //Base spread
	if(!wielded)
		return 0.1
	return 0.025

/obj/item/weapon/ranged/bullet/pump/combat_shotgun/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED,0,100))