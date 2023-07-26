/obj/item/bullet_cartridge/halo/fuelrod
	name = "fuel rod"
	desc = "BIG GUN - BIG BOOM!"
	desc_extended = "The strange alien fuel rod, used as a main ammunition for Type-33 LAA Weapon"
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/rod.dmi'
	icon_state = "bullet"

	amount_max = 1
	amount_max_icon = 1

	bullet_length = 800
	bullet_diameter = 70

	projectile = /obj/projectile/bullet/rocket_fuelrod
	damage_type_bullet = /damagetype/ranged/bullet/rocket/he

	projectile_speed = TILE_SIZE * 0.9

	size = 2

	caseless = TRUE

	bullet_insert_sound = 'sound/weapons/ranged/rifle/rocket/rocket_insert.ogg'

	value = 1 //Dummy value.

/obj/item/bullet_cartridge/halo/fuelrod/get_base_value()
	. = ..()
	. += 400