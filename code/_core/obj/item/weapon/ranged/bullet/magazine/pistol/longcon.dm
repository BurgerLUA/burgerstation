/obj/item/weapon/ranged/bullet/magazine/pistol/longcon
	name = ".45 LongCon Pistol"
	desc = "A .45 that looks like a 9mm."
	desc_extended = "A lightweight and compact Syndicate pistol chambered in .45. Tiny, but still gets the job done."
	value = 800

	company_type = "Syndicate"

	tier = 2

	icon = 'icons/obj/item/weapons/ranged/pistol/45_4.dmi'
	shoot_delay = 2
	shoot_sounds = list('sound/weapons/45/shoot.ogg')

	movement_spread_base = 0.008
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0

	automatic = FALSE

	size = SIZE_2
	weight = 5

	heat_max = 0.085

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 26 - 16
	attachment_barrel_offset_y = 22 - 16

	attachment_sight_offset_x = 12 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 21 - 16
	attachment_undermount_offset_y = 18 - 16

/obj/item/weapon/ranged/bullet/magazine/pistol/longcon/get_static_spread()
	return 0.0045

/obj/item/weapon/ranged/bullet/magazine/pistol/longcon/get_skill_spread(var/mob/living/L)
	return max(0,0.0075 - (0.02 * L.get_skill_power(SKILL_RANGED)))