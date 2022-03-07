/obj/item/weapon/ranged/bullet/pump/shotgun/tactical
	name = "12g SolTact-S"
	desc = "When you're too lazy to pump."
	desc_extended = "A lightweight 12 gauge auto-cycling semi-automatic shotgun designed to clear rooms very fast without the effort of pumping; except when you load a new round in for the first time."
	icon = 'icons/obj/item/weapons/ranged/shotgun/nanotrasen/semi.dmi'
	icon_state = "inventory"

	value = 2500

	tier = 3

	damage_mod = 1
	shoot_delay = 3

	automatic = FALSE

	can_wield = TRUE

	bullet_count_max = 4

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	size = SIZE_3
	weight = 10

	heat_max = 0.2

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
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 21 - 16
	attachment_sight_offset_y = 18 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 15 - 16

	dan_mode = TRUE

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0.5

	pump_delay = 1

/obj/item/weapon/ranged/bullet/pump/shotgun/tactical

/obj/item/weapon/ranged/bullet/pump/shotgun/tactical/get_static_spread()
	return 0.008

/obj/item/weapon/ranged/bullet/pump/shotgun/tactical/get_skill_spread(var/mob/living/L)
	return max(0,0.04 - (0.06 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/tactical/get_base_spread()
	return 0.25

/obj/item/weapon/ranged/bullet/pump/shotgun/tactical/handle_ammo(var/mob/caller)
	. = ..()
	pump(silent = TRUE)

