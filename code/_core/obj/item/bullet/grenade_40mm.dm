/obj/item/bullet_cartridge/grenade_40mm/
	name = "40mm high explosive grenade"
	desc = "What makes ME a good demoman?"
	desc_extended = "For Grenade launchers, High explosive."
	icon = 'icons/obj/item/bullet/40mm_HE.dmi'

	amount_max = 1
	amount_max_icon = 1

	bullet_length = 46
	bullet_diameter = 40

	projectile = /obj/projectile/bullet/HE_40M
	damage_type_bullet = /damagetype/ranged/bullet/gyrojet/


	projectile_speed = TILE_SIZE * 0.9

	size = 0.1
	value = 100

	caseless = TRUE

/obj/item/bullet_cartridge/grenade_40mm/get_base_value()
	. = ..()
	. += 300


