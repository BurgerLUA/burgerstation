/obj/item/weapon/ranged/bullet/magazine/rifle/moar
	name = "\improper 5.56mm MOAR"
	desc = "Space age technology calls for space age guns. This should easily rip someone a new hole."
	desc_extended = "A 5.56mm chambered mother-of-all-rifles (MOAR) developed by the Solarian research team for space battles."
	icon = 'icons/obj/item/weapons/ranged/rifle/sol/308_advanced_new.dmi'
	icon_state = "inventory"
	value = 12000

	tier = 3

	shoot_delay = 1

	damage_mod = 1.2

	automatic = TRUE

	firemodes = list("burst","automatic","semi-automatic")

	shoot_sounds = list('sound/weapons/308/shoot_sharp.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 14

	heat_max = 0.15

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ai_heat_sensitivity = 1

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 15 - 16

	attachment_sight_offset_x = 22 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 23 - 16
	attachment_undermount_offset_y = 13 - 16

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0.75
	movement_spread_base = 0.0075

	dan_mode = TRUE

/obj/item/weapon/ranged/bullet/magazine/rifle/moar/get_static_spread()
	return 0.02

/obj/item/weapon/ranged/bullet/magazine/rifle/moar/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))