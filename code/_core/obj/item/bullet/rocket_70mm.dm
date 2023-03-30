/obj/item/bullet_cartridge/rocket_70mm/
	name = "70mm High Explosive Warhead"
	desc = "I'm a Rocket Man."
	desc_extended = "For RPGs, High explosive, do NOT use for rocket jumping."
	rarity = RARITY_COMMON
	icon = 'icons/obj/item/bullet/rocket.dmi'
	icon_state = "HE"

	amount_max = 1
	amount_max_icon = 1

	bullet_length = 800
	bullet_diameter = 70

	projectile = /obj/projectile/bullet/rocket_he
	damage_type_bullet = /damagetype/ranged/bullet/rocket/he

	projectile_speed = TILE_SIZE * 0.9

	size = 2

	caseless = TRUE

	bullet_insert_sound = 'sound/weapons/ranged/rifle/rocket/rocket_insert.ogg'

	value = 1 //Dummy value.

/obj/item/bullet_cartridge/rocket_70mm/get_base_value()
	. = ..()
	. += 400

/obj/item/bullet_cartridge/rocket_70mm/wp
	name = "70mm White Phosphorous Warhead"
	desc = "I'm a Rocket Man."
	desc_extended = "For RPGs, White Phosphorous, didn't they ban this in the Space Geneva Convention...?"
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/rocket.dmi'
	icon_state = "WP"

	amount_max = 1
	amount_max_icon = 1

	bullet_length = 800
	bullet_diameter = 70

	projectile = /obj/projectile/bullet/rocket_wp
	damage_type_bullet = /damagetype/ranged/bullet/rocket/wp

	projectile_speed = TILE_SIZE * 0.9

	size = 2

/obj/item/bullet_cartridge/rocket_70mm/nuclear
	name = "70mm nuclear Warhead"
	desc = "Look at me im Davy Crocket!"
	desc_extended = "For RPGs, wAIT IS THAT A FUCKING NUKE?!?"
	rarity = RARITY_RARE
	value_burgerbux = 1
	icon = 'icons/obj/item/bullet/rocket.dmi'
	icon_state = "NUKE"

	amount_max = 1
	amount_max_icon = 1

	bullet_length = 800
	bullet_diameter = 70
	value_burgerbux = 1
	projectile = /obj/projectile/bullet/rocket_nuclear
	damage_type_bullet = /damagetype/ranged/bullet/rocket/nuclear

	projectile_speed = TILE_SIZE * 0.7

	size = 2

/obj/item/bullet_cartridge/rocket_70mm/wp/get_base_value()
	. = ..()
	. += 200

/obj/item/bullet_cartridge/rocket_70mm/ap
	name = "70mm Armor Piercing Warhead"
	desc = "I'm a Rocket Man."
	desc_extended = "For RPGs, Armor Piercing, dual explosive charge for superb penetration."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/rocket.dmi'
	icon_state = "AP"

	amount_max = 1
	amount_max_icon = 1

	bullet_length = 800
	bullet_diameter = 70

	projectile = /obj/projectile/bullet/rocket_ap
	damage_type_bullet = /damagetype/ranged/bullet/rocket/ap

	projectile_speed = TILE_SIZE * 0.9

	size = 2

/obj/item/bullet_cartridge/rocket_70mm/ap/get_base_value()
	. = ..()
	. += 200
