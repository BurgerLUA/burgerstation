/obj/item/weapon/ranged/bullet/magazine/pistol/laton
	name = "9mm Laton Pistol"
	desc = "9mm is all you need."
	desc_extended = "NT's standard pistol, chambered in the superior 9mm cartridge."
	value = 90
	icon = 'icons/obj/item/weapons/ranged/pistol/9mm_nt_2.dmi'
	shoot_delay = 1.5
	shoot_sounds = list('sound/weapons/40/shoot.ogg')

	view_punch = 8

	automatic = FALSE

	size = SIZE_2
	weight = 3


	heat_per_shot = 0.01
	heat_max = 0.075

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

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

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x =30 - 16
	attachment_barrel_offset_y = 22 - 16

	attachment_sight_offset_x = 23 - 16
	attachment_sight_offset_y = 23 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 16 - 16

/obj/item/weapon/ranged/bullet/magazine/pistol/laton/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/pistol/laton/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)) )