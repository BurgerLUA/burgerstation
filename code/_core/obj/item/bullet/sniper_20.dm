/obj/item/bullet_cartridge/sniper_20
	name = "\improper 20x117mm sniper round"
	desc = "For when you really want something to die."
	desc_extended = "For guns that require 20x117mm ammo."
	icon = 'icons/obj/item/bullet/20mm.dmi'

	bullet_diameter = 20
	bullet_length = 117
	bullet_color = COLOR_BULLET

	item_count_max = 4
	item_count_max_icon = 4

	projectile = /obj/projectile/bullet/firearm/sniper
	damage_type_bullet = /damagetype/ranged/bullet/sniper_20

	projectile_speed = BULLET_SPEED_SNIPER

	size = 0.2
	value = 20

	penetrations = 3

/obj/item/bullet_cartridge/sniper_20/surplus
	name = "\improper surplus 20x117mm sniper round"
	damage_type_bullet = /damagetype/ranged/bullet/bmg_50/surplus
	jam_chance = 1
	value = 0