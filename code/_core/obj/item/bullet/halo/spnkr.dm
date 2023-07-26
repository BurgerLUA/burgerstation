/obj/item/bullet_cartridge/halo/spnkr
	name = "M21 antipersonnel rocket"
	desc = "I'm a Rocket Man."
	desc_extended = "The M21 antipersonnel rocket is a special warfare munition capable of being fired from the M41 SPNKR rocket launcher."
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

/obj/item/bullet_cartridge/halo/spnkr/get_base_value()
	. = ..()
	. += 400