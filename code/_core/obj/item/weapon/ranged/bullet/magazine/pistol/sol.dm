/obj/item/weapon/ranged/bullet/magazine/pistol/sol
	name = "10mm Lugernut pistol"
	desc = "Cheaper than tablewine."
	desc_extended = "A substandard Solarian pistol commonly distributed to conscripts or those who opened a bank account for the first time. The oversized slider is known to break the thumbs of those who hold it incorrectly."
	icon = 'icons/obj/item/weapons/ranged/pistol/10mm.dmi'
	icon_state = "inventory"
	value = 200

	tier = 1

	shoot_delay = 3

	automatic = FALSE

	movement_spread_base = 0.01
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0

	shoot_sounds = list('sound/weapons/10/shoot.ogg')

	can_wield = FALSE

	size = SIZE_2
	weight = 5

	heat_max = 0.15

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

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
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 28 - 16
	attachment_barrel_offset_y = 21 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 24 - 16
	attachment_undermount_offset_y = 17 - 16



/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/get_static_spread()
	return 0.003

/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/get_skill_spread(var/mob/living/L)
	return max(0,0.0075 - (0.035 * L.get_skill_power(SKILL_RANGED)))