/obj/item/weapon/ranged/bullet/magazine/heavy_sniper
	name = "heavy sniper rifle"
	icon = 'icons/obj/items/weapons/ranged/heavy_sniper.dmi'
	icon_state = "inventory"

	projectile = /obj/projectile/bullet/sniper/
	ranged_damage_type = /damagetype/ranged/sniper_50
	damage_type = /damagetype/sword/

	bullet_speed = 31
	shoot_delay = 20

	automatic = FALSE

	bullet_capacity = 1 //One in the chamber

	bullet_type = ".50"

	shoot_sounds = list('sounds/weapon/ranged/bullet/heavy_sniper.ogg')

	can_wield = TRUE
	wield_only = TRUE

/obj/item/weapon/ranged/bullet/magazine/heavy_sniper/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/heavy_sniper/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED,0,100))