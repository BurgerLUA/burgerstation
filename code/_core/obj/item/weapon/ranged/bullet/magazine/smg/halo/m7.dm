/obj/item/weapon/ranged/bullet/magazine/smg/halo/m7
	name = "M7 submachine gun"
	desc = "Precision in the palms of your hands."
	desc_extended = "The M7/Caseless Submachine Gun is a fully automatic close quarters infantry and special operations weapon. Takes 5mm calibre magazines."
	icon = 'icons/obj/item/weapons/ranged/smg/halo/m7.dmi'

	shoot_delay = 1.5

	automatic = TRUE

	shoot_sounds = list(
	'sound/weapons/unsc/m7/m7_fire1.wav',
	'sound/weapons/unsc/m7/m7_fire2.wav',
	'sound/weapons/unsc/m7/m7_fire3.wav'
	)

	can_wield = FALSE

	view_punch = 3

	size = SIZE_2
	weight = 5

	heat_per_shot = 0.01
	heat_max = 0.03

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

	value = 100

	ai_heat_sensitivity = 0.5

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

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 14 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 17 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/nanotrasen

/obj/item/weapon/ranged/bullet/magazine/smg/halo/m7/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/smg/halo/m7/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.04 - (0.06 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/smg/halo/m7/insurrection
	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate