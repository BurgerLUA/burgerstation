/obj/item/weapon/ranged/bullet/magazine/pistol/holy45
	name = "Holy .45 M1911 Pistol"
	desc = "We can't expect God to do all the work."
	desc_extended = "The tool to carry out God's will."
	value = 2000

	tier = 4

	icon = 'icons/obj/item/weapons/ranged/pistol/holy45.dmi'
	shoot_delay = 1.75
	shoot_sounds = list('sound/weapons/45/shoot.ogg')

	movement_spread_base = 0.008
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0

	size = SIZE_2
	weight = 8

	heat_max = 0.1

	bullet_length_min = 20
	bullet_length_best = 24
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.777
	bullet_diameter_max = 11.77

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/charger/advanced = FALSE, // Fuck you, grind prayer. No shortcuts.
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
		/obj/item/attachment/sight/targeting_computer = FALSE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 29 - 16 // Note to myself,y offset is basically value a - value b = distance from bottom pixel. cursed system
	attachment_barrel_offset_y = 18 - 14

	attachment_sight_offset_x = 12 - 16
	attachment_sight_offset_y = 22 - 17

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 16 - 16



/obj/item/weapon/ranged/bullet/magazine/pistol/holy45/get_static_spread()
	return 0.003

/obj/item/weapon/ranged/bullet/magazine/pistol/holy45/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.03 * L.get_skill_power(SKILL_RANGED)))