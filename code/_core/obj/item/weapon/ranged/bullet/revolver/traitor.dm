/obj/item/weapon/ranged/bullet/revolver/traitor_357
	name = "\improper .357 Traditore Revolver"
	desc = "For all your traitor needs!"
	desc_extended = "An Italian made 357 revolver, the Traditore is so cheap it's basically ubiquitous, often ending up among the hands of those of less than savory repute."
	icon = 'icons/obj/item/weapons/ranged/revolver/357.dmi'
	icon_state = "inventory"
	value = 300

	tier = 2

	shoot_delay = 2

	automatic = FALSE

	bullet_count_max = 6

	shoot_sounds = list('sound/weapons/traitor/fire.ogg')

	size = SIZE_2
	weight = 7

	bullet_length_min = 20
	bullet_length_best = 33
	bullet_length_max = 35

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	heat_max = 0.05

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 30 - 16
	attachment_barrel_offset_y = 21 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 19 - 16



	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.75
	movement_spread_base = 0.04


/obj/item/weapon/ranged/bullet/revolver/traitor_357/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/bullet/revolver/traitor_357/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.01 * L.get_skill_power(SKILL_RANGED)))