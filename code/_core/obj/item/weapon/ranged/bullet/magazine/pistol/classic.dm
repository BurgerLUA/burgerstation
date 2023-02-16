/obj/item/weapon/ranged/bullet/magazine/pistol/classic
	name = "\improper 9x19mm T-Defender pistol"
	desc = "They don't make them like they used to."
	desc_extended = "A rare functioning replica of pistol carried into battle by the very first NanoTrasen miners when they were allowed to carry their own guns. A lot has changed, since then."
	value = 400
	icon = 'icons/obj/item/weapons/ranged/pistol/9mm_classic.dmi'
	shoot_delay = 1.3
	shoot_sounds = list('sound/weapons/ranged/pistol/fortress/shoot.ogg')
	tier = 1

	company_type = "NanoTrasen"

	movement_spread_base = 0.005
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0

	automatic = FALSE

	size = SIZE_2
	weight = 3

	heat_max = 0.07

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

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
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 26 - 16
	attachment_barrel_offset_y = 21 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 21 - 16
	attachment_undermount_offset_y = 17 - 16

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bullet/magazine/pistol/classic/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/pistol/classic/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.03 * L.get_skill_power(SKILL_RANGED)) )