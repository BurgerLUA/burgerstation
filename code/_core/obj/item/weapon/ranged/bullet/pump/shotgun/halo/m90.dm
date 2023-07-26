/obj/item/weapon/ranged/bullet/pump/shotgun/halo/m90
	name = "M90 Combat Shotgun"
	desc = "The most standard shotgun in the UNSC forces."
	desc_extended = "The UNSC's primary shotgun and one of the most effective close range infantry weapons used by front line forces."
	icon = 'icons/obj/item/weapons/ranged/shotgun/m90.dmi'
	icon_state = "inventory"
	value = 800

	company_type = "UNSC"

	tier = 2

	shoot_delay = 5

	automatic = FALSE

	bullet_count_max = 12

	shoot_sounds = list(
	'sound/weapons/halo/unsc/shotgun/shotgun1.wav',
	'sound/weapons/halo/unsc/shotgun/shotgun2.wav',
	'sound/weapons/halo/unsc/shotgun/shotgun3.wav')

	can_wield = TRUE

	size = SIZE_4
	weight = 11

	heat_max = 0.08

	bullet_length_min = 76
	bullet_length_best = 76.2
	bullet_length_max = 76.4

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19

	dan_mode = TRUE

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/charger/advanced = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = FALSE,
		/obj/item/attachment/stock_mod/reinforced_stock = FALSE,

		/obj/item/attachment/sight/laser_sight = FALSE,
		/obj/item/attachment/sight/quickfire_adapter = FALSE,
		/obj/item/attachment/sight/red_dot = FALSE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = FALSE,



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)
	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 21 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 29 - 16
	attachment_undermount_offset_y = 15 - 16

	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.25

	pump_delay = 3

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bullet/pump/shotgun/halo/m90/get_static_spread()
	return 0.004

/obj/item/weapon/ranged/bullet/pump/shotgun/halo/m90/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/halo/m90/get_base_spread()
	return 0.1