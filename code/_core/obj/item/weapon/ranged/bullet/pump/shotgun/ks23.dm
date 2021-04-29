/obj/item/weapon/ranged/bullet/pump/shotgun/ks23
	name = "23x75mmR KS23 Shotgun"
	desc = "Technically a Carbine!"
	desc_extended = "A russian shotgun with a rifled barrel and a 23mm bore."
	icon = 'icons/obj/item/weapons/ranged/shotgun/ks23.dmi'
	icon_state = "inventory"
	value = 1800

	can_wield = TRUE

	dan_mode = TRUE

	shoot_delay = 4

	automatic = FALSE

	bullet_count_max = 3

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	bullet_length_min = 73
	bullet_length_best = 75
	bullet_length_max = 78

	bullet_diameter_min = 21
	bullet_diameter_best = 23
	bullet_diameter_max = 25

	size = SIZE_4
	weight = 16

	heat_max = 0.18

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

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 9 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 28 - 16
	attachment_undermount_offset_y = 15 - 16



	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.25

/obj/item/weapon/ranged/bullet/pump/shotgun/ks23/get_base_spread()
	return 0.1

/obj/item/weapon/ranged/bullet/pump/shotgun/ks23/get_static_spread()
	return 0.003

/obj/item/weapon/ranged/bullet/pump/shotgun/ks23/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.025 - (0.01 * L.get_skill_power(SKILL_RANGED)))