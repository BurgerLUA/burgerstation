/obj/item/bullet_cartridge/halo/m25
	name = "M25 antipersonnel rocket"
	desc = "What makes ME a good demoman?"
	desc_extended = "The M25 antipersonnel rocket is a special warfare munition capable of being fired from the ACL-55."
	rarity = RARITY_UNCOMMON
	icon = 'icons/obj/item/bullet/m25.dmi'
	icon_state = "bullet"

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

/obj/item/bullet_cartridge/halo/m25/get_base_value()
	. = ..()
	. += 400