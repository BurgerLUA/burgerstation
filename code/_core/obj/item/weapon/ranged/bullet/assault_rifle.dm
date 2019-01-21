/obj/item/weapon/ranged/bullet/magazine/assault_rifle
	name = "assault rifle"
	icon = 'icons/obj/items/weapons/ranged/machine.dmi'
	icon_state = "inventory"

	projectile = /obj/projectile/bullet/rifle/
	ranged_damage_type = /damagetype/ranged/rifle_762
	damage_type = /damagetype/sword/

	bullet_speed = 31
	shoot_delay = 3

	automatic = FALSE

	bullet_capacity = 1 //One in the chamber

	bullet_type = "7.62"

	shoot_sounds = list('sounds/weapon/ranged/gunshot_saw.ogg')

	can_wield = TRUE

/obj/item/weapon/ranged/bullet/magazine/assault_rifle/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/assault_rifle/get_skill_spread(var/mob/living/L) //Base spread
	return 0.1 - (0.1 * L.get_skill_power(SKILL_RANGED,0,100))