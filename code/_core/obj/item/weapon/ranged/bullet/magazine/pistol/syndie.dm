/obj/item/weapon/ranged/bullet/magazine/pistol/syndie
	name = "10mm Stechkin"
	desc = "The traitor's second best friend."
	desc_extended = "The standard Syndicate pistol. Cheap. Reliable. The compactness of the gun makes it useful in assassinations as well as a holdout weapon."
	icon = 'icons/obj/item/weapons/ranged/pistol/10mm.dmi'
	icon_state = "inventory"
	value = 250

	tier = 1

	shoot_delay = 2

	automatic = FALSE

	movement_spread_base = 0.01
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0

	shoot_sounds = list('sound/weapons/10/shoot.ogg')

	can_wield = FALSE

	size = SIZE_2
	weight = 3

	heat_max = 0.12

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

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
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 24 - 16

	attachment_undermount_offset_x = 26 - 16
	attachment_undermount_offset_y = 14 - 16



/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/get_static_spread()
	return 0.004

/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.03 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/pistol/syndie/mod
	name = "10mm Stechkin MOD"
	icon = 'icons/obj/item/weapons/ranged/pistol/10mm_2.dmi'
	desc = "The traitor's second best friend."
	desc_extended = "A standard Syndicate pistol modified with better materials. This variant is more compact."

	size = SIZE_1

	attachment_barrel_offset_x = 25 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 24 - 16

	attachment_undermount_offset_x = 26 - 16
	attachment_undermount_offset_y = 14 - 16
