/obj/item/weapon/ranged/bullet/magazine/pistol/brown
	name = ".40 Brown"
	icon = 'icons/obj/item/weapons/ranged/pistol/40_1.dmi'
	desc_extended = "A decently powerful and accurate .40 semi-automatic pistol meant for self defense. Commonly used by mercenaries."
	value = 650
	shoot_sounds = list('sound/weapons/40/shoot_mod.ogg')
	shoot_delay = 1.25

	movement_spread_base = 0.0075
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0

	automatic = FALSE

	size = SIZE_2
	weight = 4

	heat_max = 0.10

	bullet_length_min = 21
	bullet_length_best = 22
	bullet_length_max = 23

	bullet_diameter_min = 9.8
	bullet_diameter_best = 10
	bullet_diameter_max = 11.2

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,

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
	attachment_barrel_offset_y = 22 - 16

	attachment_sight_offset_x = 10 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 18 - 16

	tier = 2


/obj/item/weapon/ranged/bullet/magazine/pistol/brown/get_static_spread()
	return 0.002

/obj/item/weapon/ranged/bullet/magazine/pistol/brown/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/pistol/brown/mod
	name = ".40 Brown MOD"
	icon = 'icons/obj/item/weapons/ranged/pistol/40_2.dmi'

	shoot_delay = 1.15

	size = SIZE_2
	weight = 3

	heat_max = 0.07

/obj/item/weapon/ranged/bullet/magazine/pistol/brown/mod/silenced/Generate()

	. = ..()

	attachment_barrel = new/obj/item/attachment/barrel/suppressor(src)
	INITIALIZE(attachment_barrel)
	GENERATE(attachment_barrel)
	FINALIZE(attachment_barrel)
