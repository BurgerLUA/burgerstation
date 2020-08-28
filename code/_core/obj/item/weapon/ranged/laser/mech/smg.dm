
/obj/item/weapon/ranged/energy/mech/smg/
	bullet_color = COLOR_BULLET

	heat_per_shot = 0.01
	heat_max = 0.03

/obj/item/weapon/ranged/energy/mech/smg/get_static_spread() //Base spread
	return 0.005

/obj/item/weapon/ranged/energy/mech/smg/get_skill_spread(var/mob/living/L) //Base spread
	return 0

