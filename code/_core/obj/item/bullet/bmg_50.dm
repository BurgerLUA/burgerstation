/obj/item/bullet_cartridge/bmg_50/
	name = "\improper .50 BMG round"
	desc = "A cheap, mass-produced bullet imitating a .50 cal round."
	desc_extended = "For machineguns that require .50 ammo."
	icon = 'icons/obj/item/bullet/50.dmi'


	bullet_diameter = 12.7
	bullet_length = 99
	bullet_color = COLOR_BULLET

	item_count_max = 4
	item_count_max_icon = 4

	projectile = /obj/projectile/bullet/firearm/sniper
	damage_type_bullet = /damagetype/ranged/bullet/sniper_50

	projectile_speed = BULLET_SPEED_SNIPER

	size = 0.1
	value = 8

	penetrations = 2

/obj/item/bullet_cartridge/bmg_50/surplus
	name = "\improper surplus .50 BMG round"
	damage_type_bullet = /damagetype/ranged/bullet/bmg_50/surplus
	jam_chance = 1
	value = 0