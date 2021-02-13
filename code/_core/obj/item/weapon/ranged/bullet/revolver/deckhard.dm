/obj/item/weapon/ranged/bullet/revolver/deckhard
	name = "\improper .44 space detective revolver"
	desc = "A sidearm commonly used by space police. Uses .44 rounds."
	desc_extended = "While Semiautos have become standard issue for Space Police, diehard Seargeants still tout the higher reliability of a revolver as a reason to carry these."
	icon = 'icons/obj/item/weapons/ranged/deckhard_mine.dmi'
	icon_state = "inventory"

	projectile_speed = 31
	shoot_delay = 4

	automatic = TRUE

	bullet_count_max = 6



	shoot_sounds = list('sound/weapons/deckhard/shot.ogg')

	view_punch = 8



	size = SIZE_2
	weight = 6


	bullet_length_min = 10
	bullet_length_best = 29
	bullet_length_max = 30

	bullet_diameter_min = 10
	bullet_diameter_best = 10.9
	bullet_diameter_max = 11

	heat_per_shot = 0.04
	heat_max = 0.1

	value = 60

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

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 23 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 23 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 21 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/deathsquad

/obj/item/weapon/ranged/bullet/revolver/deckhard/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/revolver/deckhard/get_skill_spread(var/mob/living/L)
	return max(0,0.0075 - (0.0075 * L.get_skill_power(SKILL_RANGED)))