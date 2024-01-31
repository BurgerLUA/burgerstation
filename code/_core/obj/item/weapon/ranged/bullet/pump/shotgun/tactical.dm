/obj/item/weapon/ranged/bullet/pump/shotgun/tactical
	name = "12g SolTact"
	desc = "Tactful."
	desc_extended = "A lightweight 12 gauge pump action Solarian-designed shotgun."
	icon = 'icons/obj/item/weapons/ranged/shotgun/sol/tactical.dmi'
	icon_state = "inventory"

	company_type = "Solarian"

	value = 2500

	tier = 3

	damage_mod = 1
	shoot_delay = 3

	automatic = FALSE

	can_wield = TRUE

	bullet_count_max = 4

	shoot_sounds = list('sound/weapons/ranged/shotgun/tactical/shoot.ogg')

	size = SIZE_3
	weight = 10

	bullet_length_min = 76
	bullet_length_best = 76.2
	bullet_length_max = 76.4

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19

	heat_max = 0.2

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = TRUE,
		/obj/item/attachment/stock_mod/reinforced_stock = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 30 - 16
	attachment_undermount_offset_y = 15 - 16

	dan_mode = TRUE

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0.5

	pump_delay = 1

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bullet/pump/shotgun/tactical

/obj/item/weapon/ranged/bullet/pump/shotgun/tactical/get_static_spread()
	return 0.008

/obj/item/weapon/ranged/bullet/pump/shotgun/tactical/get_skill_spread(mob/living/L)
	return max(0,0.04 - (0.06 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/tactical/get_base_spread()
	return 0.25
