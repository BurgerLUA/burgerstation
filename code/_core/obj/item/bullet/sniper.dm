/obj/item/bullet/sniper_50/
	name = "\improper .50 sniper round"
	desc = "For sniper rifles that require .50 ammo."
	id = ".50"
	icon = 'icons/obj/items/bullet/50.dmi'

	item_count_max = 4
	item_count_max_icon = 4

	projectile = /obj/projectile/bullet/sniper
	damage_type = ".50"

	projectile_speed = BULLET_SPEED_SNIPER


/obj/item/bullet/sniper_50/surplus
	name = "\improper surplus .50 sniper round"
	desc = "For sniper rifles that require .50 ammo. This is surplus."
	icon = 'icons/obj/items/bullet/50_surplus.dmi'
	damage_type = ".50_surplus"

	projectile_speed = BULLET_SPEED_SNIPER * SURPLUS_PENALTY

	misfire_chance = 1