/obj/item/bullet_cartridge/tranq_11m
	name = "\improper 11.43x25mm tranquilizer cartridge"
	desc = "Makes people sleep. Aim at the head for best results."
	desc_extended = "For guns that use tranquilizer rounds."
	rarity = RARITY_COMMON
	icon = 'icons/obj/item/bullet/tranq.dmi'

	item_count_max = 5
	item_count_max_icon = 5

	bullet_diameter = 11.43
	bullet_length = 25
	bullet_color = COLOR_BULLET

	projectile = /obj/projectile/bullet/firearm/pistol/stealth
	damage_type_bullet = /damagetype/ranged/bullet/tranq_11mm

	projectile_speed = BULLET_SPEED_PISTOL_LIGHT

	size = 0.01
	value = 2

	jam_chance = 100 //Required.

/obj/item/bullet_cartridge/tranq_11m/surplus
	name = "\improper surplus 11.43x25mm tranquilizer cartridge"
	damage_type_bullet = /damagetype/ranged/bullet/tranq_11mm/surplus
	misfire_chance = 1
	value = 0