/obj/item/bullet_cartridge/sniper_127
	name = "\improper 12.7x90mm sniper round"
	desc = "For when you want to shoot something so hard their family will feel it too."
	desc_extended = "For sniper rifles that require 12.7x90mm ammo."
	icon = 'icons/obj/item/bullet/127_mm.dmi'


	bullet_diameter = 12.7
	bullet_length = 90
	bullet_color = COLOR_BULLET

	item_count_max = 4
	item_count_max_icon = 4

	projectile = /obj/projectile/bullet/firearm/sniper
	damage_type_bullet = /damagetype/ranged/bullet/sniper_127

	projectile_speed = BULLET_SPEED_SNIPER

	size = 0.09
	value = 10

	penetrations = 2

/obj/item/bullet_cartridge/sniper_127/surplus
	name = "\improper surplus 12.7x90mm sniper round"
	damage_type_bullet = /damagetype/ranged/bullet/sniper_127/surplus
	jam_chance = 1
	value = 0