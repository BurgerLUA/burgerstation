/obj/item/bullet_cartridge/pulse
	name = "pulse cartridge"
	desc = "The power to supply a house for a week in a nice, compact battery."
	desc_extended = "For pulse weapons that require pulse cartridges."
	icon = 'icons/obj/item/bullet/pulse_cell.dmi'


	bullet_diameter = 13
	bullet_length = 52
	bullet_color = COLOR_GREEN

	item_count_max = 3
	item_count_max_icon = 3

	projectile = /obj/projectile/bullet/laser/strong
	damage_type_bullet = /damagetype/ranged/laser/pulse

	projectile_speed = BULLET_SPEED_SNIPER

	size = 0.1
	value = 20

/obj/item/bullet_cartridge/pulse/surplus
	name = "\improper surplus pulse cartridge"
	damage_type_bullet = /damagetype/ranged/laser/pulse/surplus
	jam_chance = 1
	value = 0