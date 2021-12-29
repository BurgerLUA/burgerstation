/obj/item/weapon/ranged/bullet/magazine/pistol/tactical
	name = ".45 1911 Pistol"
	desc = "No rubber rounds here; it's all lethal."
	desc_extended = "A common pistol used by modern police forces as well as some private military corporations. Also liked by collectors and Space Americans."
	value = 700

	tier = 2

	icon = 'icons/obj/item/weapons/ranged/pistol/45.dmi'
	shoot_delay = 1.5
	shoot_sounds = list('sound/weapons/45/shoot.ogg')

	movement_spread_base = 0.008
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0

	automatic = FALSE

	size = SIZE_2
	weight = 5

	heat_max = 0.07

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

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

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 21 - 16

	attachment_sight_offset_x = 12 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 16 - 16



/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/get_static_spread()
	return 0.003

/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.03 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/mod
	name = ".45 1911 Pistol MOD"
	desc = "It's like a Silver Eagle except not."
	desc_extended = "The feeding ramp is polished to a mirror sheen. The slide's been reinforced. And the interlock with the frame is tightened for added precision. \
	The sight system is original, too. The thumb safety is extended to make it easier on the finger. A long-type trigger with non-slip grooves. A ring hammer... \
	The base of the trigger guard's been filed down for a higher grip. And not only that, nearly every part of this gun has been expertly crafted and customized. \
	Where'd you get something like this?"
	value = 2000
	icon = 'icons/obj/item/weapons/ranged/pistol/45_2.dmi'
	shoot_delay = 1.25
	shoot_sounds = list('sound/weapons/45/shoot_mod.ogg')

	damage_mod = 1.25
	tier = 3

	size = SIZE_2

	heat_max = 0.04

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 21 - 16

	attachment_sight_offset_x = 11 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 24 - 16
	attachment_undermount_offset_y = 16 - 16

/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/mod/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/pistol/tactical/mod/get_skill_spread(var/mob/living/L)
	return max(0,0.03 - (0.03 * L.get_skill_power(SKILL_RANGED)))