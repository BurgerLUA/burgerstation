/obj/item/weapon/ranged/bullet/magazine/rifle/halo/cal30
	name = "\improper .30 Caliber Light Machine Gun"
	desc = "Atatatatatatata."
	desc_extended = "A light machine gun, made by Insurrection forces."
	icon = 'icons/obj/item/weapons/ranged/rifle/halo/30cal.dmi'

	shoot_delay = 1

	automatic = TRUE

	shoot_sounds = list(
	'sound/weapons/unsc/lmg/chaingun_fire_h3_1.wav',
	'sound/weapons/unsc/lmg/chaingun_fire_h3_2.wav',
	'sound/weapons/unsc/lmg/chaingun_fire_h3_3.wav',
	'sound/weapons/unsc/lmg/chaingun_fire_h3_4.wav',
	'sound/weapons/unsc/lmg/chaingun_fire_h3_5.wav')

	can_wield = TRUE
	wield_only = TRUE

	view_punch = 8

	heat_per_shot = 0.03
	heat_max = 0.15

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	size = SIZE_4
	weight = 30

	value = 1000

	ai_heat_sensitivity = 0.25

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/laser_charger/advanced = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,

		/obj/item/attachment/sight/laser_sight = FALSE,
		/obj/item/attachment/sight/quickfire_adapter = FALSE,
		/obj/item/attachment/sight/red_dot = FALSE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = FALSE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 11 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 13 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/cal30/get_static_spread()
	if(!wielded)
		return 0.1
	return 0.0075

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/cal30/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.02 - (0.06 * L.get_skill_power(SKILL_RANGED)))