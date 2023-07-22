/obj/item/bullet_cartridge/halo/m25
	name = "M25 antipersonnel rocket"
	desc = "What makes ME a good demoman?"
	desc_extended = "The M25 antipersonnel rocket is a special warfare munition capable of being fired from the ACL-55."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/m25.dmi'

	item_count_max = 1
	item_count_max_icon = 1

	bullet_length = 50
	bullet_diameter = 45

	projectile = /obj/projectile/bullet/rocket
	damage_type_bullet = /damagetype/ranged/bullet/gyrojet/

	misfire_chance = 15
	projectile_speed = TILE_SIZE * 0.9

	size = 2
	value = 1000