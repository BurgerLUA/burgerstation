/obj/item/weapon/ranged/energy/dynamic
	name = "\improper .50 Dynamic revolving pistol"
	desc = "Technically a revolver!."
	desc_extended = "A strangly designed .50 pistol with a revolving magazine. For a gunslinger who wants a little more punch."
	icon = 'icons/obj/item/weapons/ranged/pistol/dynamic_revolver.dmi'
	icon_state = "inventory"
	value = 700

	shoot_delay = 1.5

	movement_spread_base = 0.005
	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.5

	automatic = FALSE

	shoot_sounds = list('sound/weapons/12/shoot.ogg')

	can_wield = FALSE

	size = SIZE_2
	weight = 8

	heat_max = 0.09

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

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 21 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 15 - 16



/obj/item/weapon/ranged/energy/dynamic/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/dynamic/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.02 * L.get_skill_power(SKILL_RANGED)))