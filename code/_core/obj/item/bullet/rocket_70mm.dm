/obj/item/bullet_cartridge/rocket_70mm/
	name = "70mm High Explosive Warhead"
	desc = "I'm a Rocket Man."
	desc_extended = "For RPGs, High explosive, do NOT use for rocket jumping."
	rarity = RARITY_COMMON
	icon = 'icons/obj/item/bullet/rocket.dmi'
	icon_state = "HE"
	value = 500

	item_count_max = 1
	item_count_max_icon = 1

	bullet_length = 800
	bullet_diameter = 70

	projectile = /obj/projectile/bullet/rocket_he
	damage_type_bullet = /damagetype/ranged/bullet/rocket/he

	projectile_speed = TILE_SIZE * 0.9

	size = 2

/obj/item/bullet_cartridge/rocket_70mm/get_bullet_insert_sound()
	return 'sound/weapons/rocket/rocket_insert.ogg'

/obj/item/bullet_cartridge/rocket_70mm/wp
	name = "70mm White Phosphorous Warhead"
	desc = "I'm a Rocket Man."
	desc_extended = "For RPGs, White Phosphorous, didn't they ban this in the Space Geneva Convention...?"
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/rocket.dmi'
	icon_state = "WP"
	value = 400

	item_count_max = 1
	item_count_max_icon = 1

	bullet_length = 800
	bullet_diameter = 70

	projectile = /obj/projectile/bullet/rocket_wp
	damage_type_bullet = /damagetype/ranged/bullet/rocket/wp

	projectile_speed = TILE_SIZE * 0.9

	size = 2

/obj/item/bullet_cartridge/rocket_70mm/ap
	name = "70mm Armor Piercing Warhead"
	desc = "I'm a Rocket Man."
	desc_extended = "For RPGs, Armor Piercing, dual explosive charge for superb penetration."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/rocket.dmi'
	icon_state = "AP"
	value = 400

	item_count_max = 1
	item_count_max_icon = 1

	bullet_length = 800
	bullet_diameter = 70

	projectile = /obj/projectile/bullet/rocket_ap
	damage_type_bullet = /damagetype/ranged/bullet/rocket_ap/

	projectile_speed = TILE_SIZE * 0.9

	size = 2
