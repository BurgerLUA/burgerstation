/obj/item/weapon/ranged/energy/chronogun
	name = "chrono gun"
	icon = 'icons/obj/items/weapons/ranged/laser/chronogun.dmi'

	projectile = /obj/projectile/bullet/laser/strong
	damage_type = /damagetype/ranged/laser/chronogun

	projectile_speed = 8
	shoot_delay = 20

	automatic = FALSE

	bullet_color = "#0000FF"

	charge_max = CELL_SIZE_ADVANCED
	charge_current = CELL_SIZE_ADVANCED
	charge_cost = CELL_SIZE_ADVANCED / 5

	view_punch = 31

	shoot_sounds = list('sounds/weapons/chronogun/fire.ogg')

	heat_per_shot = 0.1
	heat_max = 0.2

/obj/item/weapon/ranged/energy/chronogun/get_static_spread() //Base spread
	return 0.005

/obj/item/weapon/ranged/energy/chronogun/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.04 - (0.08 * L.get_skill_power(SKILL_RANGED)))