/obj/item/weapon/ranged/bullet/magazine/pistol/halo/socom
	name = "M6C/SOCOM silenced magnum"
	desc = "No rubber rounds here; it's all lethal."
	desc_extended = "The M6C/SOCOM is a special operations variant of the popular M6C but with a whole host of inbuilt attachments. Takes 12.7mm calibre magazines."
	value = 50

	icon = 'icons/obj/item/weapons/ranged/pistol/halo/magnum.dmi'
	shoot_delay = 3
	shoot_sounds = list(
	'sound/weapons/unsc/m6c_socom/m6c_fire1.ogg',
	'sound/weapons/unsc/m6c_socom/m6c_fire2.ogg',
	'sound/weapons/unsc/m6c_socom/m6c_fire3.ogg'
	)

	view_punch = 6

	automatic = FALSE

	size = SIZE_2
	weight = 5


	heat_per_shot = 0.03
	heat_max = 0.12

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

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
	attachment_barrel_offset_y = 21 - 16

	attachment_sight_offset_x = 12 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 16 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/nanotrasen

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/socom/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/socom/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.03 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_2
	name = "M6B Magnum"
	desc = "The traitor's second best friend."
	desc_extended = "Common handgun accessible to civilians with a lack of a scope. Takes 12.7mm calibre magazines."
	icon = 'icons/obj/item/weapons/ranged/pistol/halo/magnum2.dmi'
	value = 40

	shoot_delay = 3

	automatic = FALSE

	shoot_sounds = list(
	'sound/weapons/unsc/magnum/magnum_stereo1.wav',
	'sound/weapons/unsc/magnum/magnum_stereo2.wav',
	'sound/weapons/unsc/magnum/magnum_stereo3.wav',
	'sound/weapons/unsc/magnum/magnum_stereo4.wav'
	)


	can_wield = FALSE

	view_punch = 8

	size = SIZE_1
	weight = 3


	heat_per_shot = 0.02
	heat_max = 0.12

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

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
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 24 - 16

	attachment_undermount_offset_x = 26 - 16
	attachment_undermount_offset_y = 14 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_2/get_static_spread()
	return 0.0025

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_2/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.03 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_3
	name = "M6G Magnum"
	desc = "The UNSC's standard sidearm."
	desc_extended = "The UNSC's standard issue sidearm. Takes 12.7mm calibre magazines."
	icon = 'icons/obj/item/weapons/ranged/pistol/halo/magnum3.dmi'
	value = 40

	shoot_delay = 3

	automatic = FALSE

	shoot_sounds = list(
	'sound/weapons/unsc/magnum/magnum_stereo1.wav',
	'sound/weapons/unsc/magnum/magnum_stereo2.wav',
	'sound/weapons/unsc/magnum/magnum_stereo3.wav',
	'sound/weapons/unsc/magnum/magnum_stereo4.wav'
	)


	can_wield = FALSE

	view_punch = 8

	size = SIZE_1
	weight = 3


	heat_per_shot = 0.02
	heat_max = 0.12

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

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
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 24 - 16

	attachment_undermount_offset_x = 26 - 16
	attachment_undermount_offset_y = 14 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/nanotrasen

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_3/get_static_spread()
	return 0.0025

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_3/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.03 * L.get_skill_power(SKILL_RANGED)))