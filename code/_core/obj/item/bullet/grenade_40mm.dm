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

/obj/item/bullet_cartridge/grenade_40mm/hv
	name = "40mm high velocity grenade"
	desc = "Loch n load."
	desc_extended = "For Grenade launchers, High velocity, low explosive payload."
	icon = 'icons/obj/item/bullet/40mm_HV.dmi'

	projectile = /obj/projectile/bullet/HV_40M
	damage_type_bullet = /damagetype/ranged/bullet/gyrojet/hv
	projectile_speed = TILE_SIZE * 1.2

/obj/item/bullet_cartridge/grenade_40mm/du
	name = "40mm mini-nuke grenade"
	desc = "KA-BOOOOOOM"
	desc_extended = "For Grenade launchers, small nuclear payload."
	icon = 'icons/obj/item/bullet/40mm_DU.dmi'
	rarity = RARITY_UNCOMMON
	value_burgerbux = 1
	projectile = /obj/projectile/bullet/DU_40M


/obj/item/bullet_cartridge/grenade_40mm/rubber
	name = "40mm rubber round"
	desc = "OW THAT HURTS"
	desc_extended = "For Grenade launchers, non-lethal"
	icon = 'icons/obj/item/bullet/40mm_RUBBER.dmi'

	damage_type_bullet = /damagetype/ranged/bullet/gyrojet/rubber_grenade
	projectile = /obj/projectile/bullet/RUBBER_40M
