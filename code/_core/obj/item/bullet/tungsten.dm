/obj/item/bullet_cartridge/tungsten
	name = "tungsten bolt"
	desc = "A small tungsten rod designed to be shot at heavily armored targets."
	icon = 'icons/obj/items/bullet/tungsten.dmi'
	item_count_max = 5
	item_count_max_icon = 5
	icon_state = "t"

	id = "tungsten"
	bullet_length = 20
	bullet_diameter = 5

	worn_layer = LAYER_MOB_CLOTHING_BELT
	item_slot = SLOT_GROIN_O

	projectile = /obj/projectile/bullet/tungsten
	damage_type = "bolt_metal"

	projectile_speed = BULLET_SPEED_MAX

	size = 0.5
	weight = 1

	value = 3