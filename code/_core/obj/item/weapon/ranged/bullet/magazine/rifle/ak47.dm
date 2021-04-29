/obj/item/weapon/ranged/bullet/magazine/rifle/ak47
	name = "\improper 7.62x39mmR AK-47"
	desc = "Ancient, with an upgrade."
	desc_extended = "The 7.62x54mmR AK-14 is the AK to go for when you seriously want to fuck shit up."
	icon = 'icons/obj/item/weapons/ranged/rifle/rev/762_rifle.dmi'
	icon_state = "inventory"
	value = 2200

	shoot_delay = 2

	automatic = TRUE

	firemodes = list("semi-automatic","automatic")

	shoot_sounds = list('sound/weapons/308/shoot_long.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 18

	heat_max = 0.2

	bullet_length_min = 46
	bullet_length_best = 54
	bullet_length_max = 58

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	ai_heat_sensitivity = 2

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
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 12 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 23 - 16
	attachment_undermount_offset_y = 19 - 16



	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 1.75
	movement_spread_base = 0.025

	dan_mode = TRUE

/obj/item/weapon/ranged/bullet/magazine/rifle/ak47/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/rifle/ak47/get_skill_spread(var/mob/living/L)
	return max(0,0.025 - (0.05 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/magazine/rifle/ak47/short
	name = "\improper 7.62x39mmR AK-47-SU"
	desc = "Tiny tiny gun."
	desc_extended = "The 7.62x54mmR AK-47-SU is the AK to go for when you seriously want to fuck shit upm, but with compactness."
	icon = 'icons/obj/item/weapons/ranged/rifle/rev/762_carbine.dmi'
	icon_state = "inventory"
	value = 1800

	shoot_delay = 1.5

	size = SIZE_3
	weight = 10

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 1.25
	movement_spread_base = 0.01