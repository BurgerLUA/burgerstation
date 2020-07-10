/obj/item/bullet_cartridge/gyrojet/
	name = "\improper 20mm gyrorocket"
	desc = "Rocket Punch!"
	desc_extended = "For pistols and rifles that require gyrojet rounds. Even well made rounds are known for their high misfire chance."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/gyrojet.dmi'

	item_count_max = 4
	item_count_max_icon = 4

	bullet_length = 50
	bullet_diameter = 20

	projectile = /obj/projectile/bullet/gyrojet
	damage_type_bullet = /damagetype/ranged/bullet/gyrojet/


	projectile_speed = TILE_SIZE * 0.9

	misfire_chance = 5

	size = 0.1
	weight = 0.5
	value = 15

/obj/item/bullet_cartridge/gyrojet/surplus
	name = "\improper surplus 20mm gyrorocket"
	misfire_chance = 20


