/obj/item/bullet_cartridge/grenade_40mm/
	name = "40mm high explosive grenade"
	desc = "What makes ME a good demoman?"
	desc_extended = "For Grenade launchers, High explosive."
	icon = 'icons/obj/item/bullet/40mm_high_explosive.dmi'

	amount_max = 1
	amount_max_icon = 1

	bullet_length = 46
	bullet_diameter = 40

	projectile = /obj/projectile/bullet/grenade/he
	damage_type_bullet = /damagetype/ranged/bullet/grenade


	projectile_speed = TILE_SIZE * 0.5

	size = 0.1
	value = 1 //Dummy value.

	caseless = TRUE

/obj/item/bullet_cartridge/grenade_40mm/get_base_value()
	. = ..()
	. += 300

/obj/item/bullet_cartridge/grenade_40mm/hv
	name = "40mm high velocity grenade"
	desc = "Loch n load."
	desc_extended = "For Grenade launchers, High velocity, low explosive payload."
	icon = 'icons/obj/item/bullet/40mm_high_velocity.dmi'

	projectile = /obj/projectile/bullet/grenade/hv
	damage_type_bullet = /damagetype/ranged/bullet/grenade/high_velocity
	projectile_speed = TILE_SIZE - 1

	rarity = RARITY_UNCOMMON

/obj/item/bullet_cartridge/grenade_40mm/du
	name = "40mm mini-nuke grenade"
	desc = "KA-BOOOOOOM"
	desc_extended = "For Grenade launchers, small nuclear payload."
	icon = 'icons/obj/item/bullet/40mm_uranium.dmi'
	rarity = RARITY_UNCOMMON
	value_burgerbux = 1
	projectile = /obj/projectile/bullet/grenade/du

	rarity = RARITY_RARE


/obj/item/bullet_cartridge/grenade_40mm/rubber
	name = "40mm rubber round"
	desc = "OW THAT HURTS"
	desc_extended = "For Grenade launchers, non-lethal"
	icon = 'icons/obj/item/bullet/40mm_rubber.dmi'

	projectile = /obj/projectile/bullet/grenade/rubber
	damage_type_bullet = /damagetype/ranged/bullet/grenade/rubber

	rarity = RARITY_UNCOMMON


/obj/item/bullet_cartridge/grenade_40mm/cleaning
	name = "40mm cleaning round"
	desc = "For long ranged instant-impact cleaning."
	desc_extended = "A 40mm grenade designed to clean a moderately sized area on impact."
	icon = 'icons/obj/item/bullet/40mm_cleaning.dmi'

	projectile = /obj/projectile/bullet/grenade/cleaning
	damage_type_bullet = /damagetype/ranged/bullet/gyrojet/rubber_grenade

	rarity = RARITY_UNCOMMON

/obj/item/bullet_cartridge/grenade_40mm/incendiary
	name = "40mm incendiary round"
	desc = "For when you need that specific area over there on fire."
	desc_extended = "A 40mm grenade designed to set fire to a small area on impact."
	icon = 'icons/obj/item/bullet/40mm_incendiary.dmi'

	projectile = /obj/projectile/bullet/grenade/incendiary

	rarity = RARITY_UNCOMMON
