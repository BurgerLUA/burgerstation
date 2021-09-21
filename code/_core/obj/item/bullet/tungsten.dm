/obj/item/bullet_cartridge/tungsten
	name = "tungsten bolt"
	desc = "I hope using this isn't a war crime..."
	desc_extended = "A small tungsten rod designed to be shot at heavily armored targets."
	rarity = RARITY_COMMON
	icon = 'icons/obj/item/bullet/tungsten.dmi'
	item_count_max = 5
	item_count_max_icon = 5
	icon_state = "t"

	bullet_length = 20
	bullet_diameter = 5

	projectile = /obj/projectile/bullet/tungsten
	damage_type_bullet = /damagetype/ranged/bullet/tungsten

	projectile_speed = BULLET_SPEED_MAX

	size = 0.5
	value = 3

/obj/item/bullet_cartridge/tungsten/surplus
	name = "\improper surplus tungsten bolt"
	damage_type_bullet = /damagetype/ranged/bullet/tungsten/surplus
	misfire_chance = 1
	value = 0