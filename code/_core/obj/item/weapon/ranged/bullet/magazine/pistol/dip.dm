/obj/item/weapon/ranged/bullet/magazine/pistol/dip
	name = ".22 Z-Dip Gun"
	desc = "The best in manufactured pistols."
	desc_extended = "The Z-Dip Gun is a relatively inexpensive pistol meant for civilian self-defense. The low caliber makes it difficult to use as a serious weapon, however."
	value = 120
	icon = 'icons/obj/item/weapons/ranged/pistol/dip_gun.dmi'
	shoot_delay = 2
	shoot_sounds = list('sound/weapons/pistol/shoot.ogg')

	movement_spread_base = 0.001
	inaccuracy_modifier = 1
	movement_inaccuracy_modifier = 0

	automatic = TRUE

	size = SIZE_2
	weight = 2

	heat_max = 0.005

	bullet_length_min = 17
	bullet_length_best = 17.7
	bullet_length_max = 18

	bullet_diameter_min = 5
	bullet_diameter_best = 5.6
	bullet_diameter_max = 6

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
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 0 - 16
	attachment_undermount_offset_y = 0 - 16

	tier = 0

/obj/item/weapon/ranged/bullet/magazine/pistol/dip/get_static_spread()
	return 0.002

/obj/item/weapon/ranged/bullet/magazine/pistol/dip/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)) )