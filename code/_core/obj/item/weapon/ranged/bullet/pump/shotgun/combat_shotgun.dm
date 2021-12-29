/obj/item/weapon/ranged/bullet/pump/shotgun/combat
	name = "12g Combat Shotgun"
	desc = "Reliable and strong"
	desc_extended = "A very robust pump action shotgun for Private Military Corporations."
	icon = 'icons/obj/item/weapons/ranged/shotgun/combat.dmi'
	icon_state = "inventory"

	tier = 3

	value = 2800

	shoot_delay = 4

	damage_mod = 1.5

	automatic = FALSE

	bullet_count_max = 12

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 12

	heat_max = 0.08

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
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 14 - 16

	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.25

	pump_delay = 4

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/get_static_spread()
	return 0.002

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.005 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/get_base_spread()
	return 0.1

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod
	name = "12g Combat Shotgun MOD"
	desc = "A very robust combat shotgun. This one has been modified to be shorter."
	icon = 'icons/obj/item/weapons/ranged/shotgun/combat_mod.dmi'
	icon_state = "inventory"

	automatic = FALSE

	bullet_count_max = 4

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	can_wield = TRUE

	weight = 8
	size = SIZE_3

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod/get_static_spread()
	return 0.004

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod/get_base_spread()
	return 0.2