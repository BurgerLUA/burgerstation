/obj/item/bullet_cartridge/gyrojet/
	name = "\improper 20mm gyrorocket"
	desc = "For pistols and rifles that require gyrojet rounds. Even well made rounds are known for their high misfire chance."
	icon = 'icons/obj/items/bullet/gyrojet.dmi'

	item_count_max = 4
	item_count_max_icon = 4

	bullet_length = 50
	bullet_diameter = 20

	projectile = /obj/projectile/bullet/pistol
	damage_type_bullet = /damagetype/ranged/bullet/gyrojet/


	projectile_speed = BULLET_SPEED_LARGE_PROJECTILE

	misfire_chance = 5

	size = 0.1
	weight = 0.5
	value = 10

/obj/item/bullet_cartridge/gyrojet/surplus
	name = "\improper surplus 20mm gyrorocket"
	misfire_chance = 20