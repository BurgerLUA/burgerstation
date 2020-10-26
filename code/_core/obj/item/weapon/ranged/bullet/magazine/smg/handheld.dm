/obj/item/weapon/ranged/bullet/magazine/smg/handheld
	name = "\improper 9mm SMP"
	desc = "Spray n' Pray"
	desc_extended = "Extremely inaccurate, but brute forces that problem with it's high firerate. Dual wield for best results."
	icon = 'icons/obj/item/weapons/ranged/smg/9mm.dmi'
	icon_state = "inventory"

	shoot_delay = 1.5

	automatic = TRUE

	shoot_sounds = list('sound/weapons/45/shoot.ogg')

	can_wield = FALSE

	view_punch = 4



	size = SIZE_2
	weight = 7


	heat_per_shot = 0.03
	heat_max = 0.09

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	value = 120

	ai_heat_sensitivity = 0.5

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
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 28 - 16
	attachment_barrel_offset_y = 25 - 16

	attachment_sight_offset_x = 12 - 16
	attachment_sight_offset_y = 26 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 17 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

/obj/item/weapon/ranged/bullet/magazine/smg/handheld/get_static_spread()
	return 0.015

/obj/item/weapon/ranged/bullet/magazine/smg/handheld/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)))