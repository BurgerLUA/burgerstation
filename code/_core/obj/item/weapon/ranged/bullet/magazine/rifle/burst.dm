/obj/item/weapon/ranged/bullet/magazine/rifle/burst
	name = "\improper 5.56mm L-HON"
	desc = "Made in Space France!"
	desc_extended = "A 3-round burst assault rifle designed to quickly put down targets at medium to long ranges."
	icon = 'icons/obj/item/weapons/ranged/rifle/nanotrasen/556_3.dmi'
	icon_state = "inventory"
	value = 400

	shoot_delay = 1.25
	burst_delay = 5
	max_bursts = 3

	automatic = TRUE

	shoot_sounds = list('sound/weapons/223/shoot.ogg')

	can_wield = TRUE

	view_punch = 10

	size = SIZE_4
	weight = 12

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ai_heat_sensitivity = 0.75

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
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 17 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 24 - 16
	attachment_undermount_offset_y = 15 - 16

	dan_mode = TRUE

	heat_per_shot = 0.03
	heat_max = 0.09

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.02

/obj/item/weapon/ranged/bullet/magazine/rifle/burst/get_static_spread()
	if(!wielded) return 0.15
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/burst/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.03 - (0.06 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/burst/prototype
	name = "\improper 5.56mm L-HON-0"
	icon = 'icons/obj/item/weapons/ranged/rifle/nanotrasen/556_3_new.dmi'
	desc_extended = "A very early prototype of NanoTrasen's L-HON; the L-HON-0 is made with higher quality materials which allows for a significantly high rate of fire. Usually coveted by collectors and mercenaries alike."

	view_punch = 12

	weight = 14

	shoot_delay = 1
	burst_delay = 4
	max_bursts = 3

	value = 1400

	heat_per_shot = 0.025
	heat_max = 0.045

	firing_pin = /obj/item/firing_pin/electronic/iff/mercenary

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 16 - 16
	attachment_sight_offset_y = 23 - 16

	attachment_undermount_offset_x = 24 - 16
	attachment_undermount_offset_y = 17 - 16