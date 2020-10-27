/obj/item/weapon/ranged/bullet/magazine/rifle/svt
	name = "\improper 7.62x54mmR SVT-40"
	desc = "URAAAAAAAAAAA!"
	desc_extended = "The SVT-40 is a Russian Rifle most well known for killing Nazis. Now you too can carry that legacy in your hands!"
	icon = 'icons/obj/item/weapons/ranged/rifle/762_svt.dmi'
	icon_state = "inventory"
	value = 300

	shoot_delay = 3

	automatic = FALSE

	shoot_sounds = list('sound/weapons/308/shoot.ogg')

	can_wield = TRUE

	view_punch = 8



	size = SIZE_4
	weight = 14


	heat_per_shot = 0.01
	heat_max = 0.08

	bullet_length_min = 46
	bullet_length_best = 54
	bullet_length_max = 58

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	ai_heat_sensitivity = 1.5

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

	attachment_barrel_offset_x = 30 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 10 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 17 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/revolutionary

/obj/item/weapon/ranged/bullet/magazine/rifle/svt/get_static_spread()
	if(!wielded) return 0.2
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/svt/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.008 - (0.016 * L.get_skill_power(SKILL_RANGED)))
