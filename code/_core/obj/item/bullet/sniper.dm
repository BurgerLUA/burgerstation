/obj/item/bullet_cartridge/sniper_50/
	name = "\improper .50 sniper round"
	desc = "For sniper rifles that require .50 ammo."
	id = ".50"
	icon = 'icons/obj/items/bullet/50.dmi'

	id = "bullet"
	bullet_diameter = 12.7
	bullet_length = 99

	item_count_max = 4
	item_count_max_icon = 4

	projectile = /obj/projectile/bullet/sniper
	damage_type = ".50_sniper"

	projectile_speed = BULLET_SPEED_SNIPER

	size = 0.1
	weight = 0.1

	value = 0.15

/obj/item/bullet_cartridge/sniper_50/surplus
	name = "\improper surplus .50 sniper round"
	desc = "For sniper rifles that require .50 ammo. This is surplus."
	icon = 'icons/obj/items/bullet/50_surplus.dmi'
	damage_type = ".50_surplus"

	projectile_speed = BULLET_SPEED_SNIPER * SURPLUS_PENALTY

	misfire_chance = 1

	size = 0.1
	weight = 0.1