/obj/item/weapon/ranged/bullet/revolver/big_game
	name = "\improper .300 Big Game Revolver"
	desc = "Can't spell overkill without .300."
	desc_extended = "A BFR (Big Frame Revolver) that has to be reloaded manually, but packs a big punch. Commonly used by Megafauna hunters."
	icon = 'icons/obj/item/weapons/ranged/revolver/300.dmi'
	icon_state = "inventory"

	shoot_delay = 6

	automatic = FALSE

	bullet_count_max = 5

	shoot_sounds = list('sound/weapons/308/big_game.ogg')

	view_punch = 24

	size = SIZE_3
	weight = 10




	bullet_length_min = 40
	bullet_length_best = 46
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	value = 450

	heat_per_shot = 0.04
	heat_max = 0.1

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

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 24 - 16

	attachment_sight_offset_x = 12 - 16
	attachment_sight_offset_y = 25 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 17 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/deathsquad

/obj/item/weapon/ranged/bullet/revolver/big_game/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/revolver/big_game/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.02 * L.get_skill_power(SKILL_RANGED)))