/obj/item/weapon/ranged/bullet/magazine/pistol/halo/socom
	name = "M6C/SOCOM silenced magnum"
	desc = "No rubber rounds here; it's all lethal."
	desc_extended = "The M6C/SOCOM is a special operations variant of the popular M6C but with a whole host of inbuilt attachments. Takes 12.7mm calibre magazines."
	icon = 'icons/obj/item/weapons/ranged/pistol/halo/magnum.dmi'
	icon_state = "inventory"
	value = 500

	company_type = "UNSC"

	tier = 1
	shoot_delay = 2.8

	automatic = FALSE

	movement_spread_base = 0.003
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.0125

	shoot_sounds = list(
	'sound/weapons/halo/unsc/m6c_socom/m6c_fire1.ogg',
	'sound/weapons/halo/unsc/m6c_socom/m6c_fire2.ogg',
	'sound/weapons/halo/unsc/m6c_socom/m6c_fire3.ogg'
	)
	can_wield = FALSE

	size = SIZE_2
	weight = 6

	heat_max = 0.09

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
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

	attachment_barrel_offset_x = 28 - 16
	attachment_barrel_offset_y = 22 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 23 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 17 - 16

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/socom/get_static_spread()
	return 0.0009

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/socom/get_skill_spread(var/mob/living/L)
	return max(0,0.015 - (0.03 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_2
	name = "M6B Magnum"
	desc = "The traitor's second best friend."
	desc_extended = "Common handgun accessible to civilians with a lack of a scope. Takes 12.7mm calibre magazines."
	icon = 'icons/obj/item/weapons/ranged/pistol/halo/magnum2.dmi'
	icon_state = "inventory"
	value = 500

	company_type = "UNSC"

	tier = 1
	shoot_delay = 2.8

	automatic = FALSE

	movement_spread_base = 0.003
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.0125

	shoot_sounds = list(
	'sound/weapons/halo/unsc/magnum/magnum_stereo1.wav',
	'sound/weapons/halo/unsc/magnum/magnum_stereo2.wav',
	'sound/weapons/halo/unsc/magnum/magnum_stereo3.wav',
	'sound/weapons/halo/unsc/magnum/magnum_stereo4.wav'
	)
	can_wield = FALSE

	size = SIZE_2
	weight = 6

	heat_max = 0.09

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/charger/advanced = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = FALSE,
		/obj/item/attachment/stock_mod/reinforced_stock = FALSE,

		/obj/item/attachment/sight/laser_sight = FALSE,
		/obj/item/attachment/sight/quickfire_adapter = FALSE,
		/obj/item/attachment/sight/red_dot = FALSE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = FALSE,



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 28 - 16
	attachment_barrel_offset_y = 22 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 23 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 17 - 16

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_2/get_static_spread()
	return 0.0009

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_2/get_skill_spread(var/mob/living/L)
	return max(0,0.015 - (0.03 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_3
	name = "M6G Magnum"
	desc = "The UNSC's standard sidearm."
	desc_extended = "The UNSC's standard issue sidearm. Takes 12.7mm calibre magazines."
	icon = 'icons/obj/item/weapons/ranged/pistol/halo/magnum3.dmi'
	icon_state = "inventory"
	value = 500

	company_type = "UNSC"

	tier = 1
	shoot_delay = 2.8

	automatic = FALSE

	movement_spread_base = 0.003
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.0125

	shoot_sounds = list(
	'sound/weapons/halo/unsc/magnum/magnum_stereo1.wav',
	'sound/weapons/halo/unsc/magnum/magnum_stereo2.wav',
	'sound/weapons/halo/unsc/magnum/magnum_stereo3.wav',
	'sound/weapons/halo/unsc/magnum/magnum_stereo4.wav'
	)
	can_wield = FALSE

	size = SIZE_2
	weight = 6

	heat_max = 0.09

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/charger/advanced = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = FALSE,
		/obj/item/attachment/stock_mod/reinforced_stock = FALSE,

		/obj/item/attachment/sight/laser_sight = FALSE,
		/obj/item/attachment/sight/quickfire_adapter = FALSE,
		/obj/item/attachment/sight/red_dot = FALSE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = FALSE,



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 28 - 16
	attachment_barrel_offset_y = 22 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 23 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 17 - 16

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_3/get_static_spread()
	return 0.0009

/obj/item/weapon/ranged/bullet/magazine/pistol/halo/magnum_3/get_skill_spread(var/mob/living/L)
	return max(0,0.015 - (0.03 * L.get_skill_power(SKILL_RANGED)))