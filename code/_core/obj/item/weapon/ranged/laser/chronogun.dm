/obj/item/weapon/ranged/laser/chronogun
	name = "chrono gun"
	icon = 'icons/obj/items/weapons/ranged/chronogun.dmi'

	projectile = /obj/projectile/bullet/laser
	damage_type = "chronogun"

	projectile_speed = 8
	shoot_delay = 20

	automatic = FALSE

	bullet_color = "#0000FF"

	charge_max = CELL_SIZE_ADVANCED
	charge_current = CELL_SIZE_ADVANCED
	charge_cost = CELL_SIZE_ADVANCED / 5

	view_punch = 31

	shoot_sounds = list('sounds/weapons/chronogun/fire.ogg')