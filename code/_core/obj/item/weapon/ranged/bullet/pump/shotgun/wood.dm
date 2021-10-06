/obj/item/weapon/ranged/bullet/pump/shotgun/wood
	name = "12g Civilian Shotgun"
	desc = "Good ol' fashioned shotgun."
	desc_extended = "A classic pump action shotgun with the stock and barrel shortened. Most commonly used by hunters, but has been seen on Security and PMCs on a budget as well."
	icon = 'icons/obj/item/weapons/ranged/shotgun/regular.dmi'
	icon_state = "inventory"

	value = 800

	tier = 1

	shoot_delay = 3

	automatic = FALSE

	bullet_count_max = 6

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	size = SIZE_4
	weight = 9

	heat_max = 0.12

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

	attachment_undermount_offset_x = 30 - 16
	attachment_undermount_offset_y = 16 - 16

	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.25

	pump_delay = 2

/obj/item/weapon/ranged/bullet/pump/shotgun/wood/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/pump/shotgun/wood/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.08 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/wood/get_base_spread()
	return 0.1

/obj/item/weapon/ranged/bullet/pump/shotgun/wood/doom
	name = "That Shotgun"
	rarity = RARITY_MYTHICAL
	desc = "Packs a punch (not a kick, that's another series)."
	icon = 'icons/obj/item/weapons/ranged/shotgun/doom.dmi'
	desc_extended = "A 12 gauge wooded shotgun for those who care more about the classic shotguns than what's currently out there."
	value = 4000
	shoot_delay = 1
	heat_max = 0
	bullet_count_max = 6
	weight = 12

	dan_mode = TRUE

	can_wield = TRUE

	shoot_sounds = list('sound/weapons/12/shoot_doom.ogg')
	pump_sound = 'sound/weapons/shotgun_pump_old.ogg'

	damage_mod = 2

	tier = 4

	pump_delay = 8

/obj/item/weapon/ranged/bullet/pump/shotgun/wood/doom/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/pump/shotgun/wood/doom/get_skill_spread(var/mob/living/L)
	return max(0,0.04 - (0.08 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/wood/doom/get_base_spread()
	return 0.1