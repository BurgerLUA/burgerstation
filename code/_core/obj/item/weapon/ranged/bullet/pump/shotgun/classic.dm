/obj/item/weapon/ranged/bullet/pump/shotgun/classic
	name = "12g Fortress Defender"
	desc = "They don't make them like they used to."
	desc_extended = "A compact yet still powerful pump action shotgun meant for home and fortress defence. One of the first weapons manufactured by NanoTrasen when they were just an iron mining company."
	icon = 'icons/obj/item/weapons/ranged/shotgun/nanotrasen/pump_2.dmi'
	icon_state = "inventory"
	value = 800

	company_type = "NanoTrasen"

	tier = 2

	shoot_delay = 6.25

	automatic = FALSE

	bullet_count_max = 6

	shoot_sounds = list('sound/weapons/12gauge/shoot_team.ogg')

	can_wield = TRUE

	size = SIZE_3
	weight = 10

	heat_max = 0.1

	bullet_length_min = 76
	bullet_length_best = 76.2
	bullet_length_max = 76.4

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19

	dan_mode = TRUE

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

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 28 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 19 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 15 - 16

	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.25

	pump_delay = 3

/obj/item/weapon/ranged/bullet/pump/shotgun/classic/get_static_spread()
	return 0.015

/obj/item/weapon/ranged/bullet/pump/shotgun/classic/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.05 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/classic/get_base_spread()
	return 0.15