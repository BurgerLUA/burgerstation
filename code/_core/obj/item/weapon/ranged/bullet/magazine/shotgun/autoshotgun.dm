/obj/item/weapon/ranged/bullet/magazine/shotgun/bull
	name = "\improper 12g Double Action"
	desc = "For when you want to clear a room."
	desc_extended = "The 12 Gauge Double Action is an insanely powerful semiautomatic bullpup shotgun, nicknamed \"Bull\" for its bullpup design as well as the fact that it kicks like one too."
	icon = 'icons/obj/item/weapons/ranged/shotgun/auto.dmi'
	icon_state = "inventory"
	value = 210

	shoot_delay = 3

	automatic = FALSE

	shoot_sounds = list('sound/weapons/12gauge/shoot.ogg')

	can_wield = FALSE

	view_punch = 18

	slowdown_mul_held = HELD_SLOWDOWN_RIFLE

	size = SIZE_4


	heat_per_shot = 0.05
	heat_max = 0.15

	bullet_length_min = 18
	bullet_length_best = 18.5
	bullet_length_max = 19

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19

	value = 300

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
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 16 - 16
	attachment_sight_offset_y = 23 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 15 - 16

/obj/item/weapon/ranged/bullet/magazine/shotgun/bull/get_base_spread()
	return 0.08

/obj/item/weapon/ranged/bullet/magazine/shotgun/bull/get_static_spread() //Base spread
	return 0.002

/obj/item/weapon/ranged/bullet/magazine/shotgun/bull/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.05 - (0.1 * L.get_skill_power(SKILL_RANGED)))