/obj/item/weapon/ranged/bullet/pump/shotgun/doom
	name = "That Shotgun"
	desc = "Packs a punch (not a kick, that's another series)."
	desc_extended = "A 12 gauge wooded shotgun for those who care more about the classic shotguns than what's currently out there."
	icon = 'icons/obj/item/weapons/ranged/shotgun/sol/classic.dmi'

	company_type = "Solarian"

	shoot_sounds = list('sound/weapons/12/shoot_doom.ogg')
	pump_sound = 'sound/weapons/shotgun_pump_old.ogg'

	value = 4000
	tier = 3

	automatic = FALSE

	shoot_delay = 4
	damage_mod = 2
	heat_max = 0
	bullet_count_max = 6
	pump_delay = 6

	size = SIZE_4
	weight = 12

	can_wield = TRUE

	dan_mode = TRUE

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



		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)


	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 20 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 31 - 16
	attachment_undermount_offset_y = 18 - 16

	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.25

/obj/item/weapon/ranged/bullet/pump/shotgun/doom/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/pump/shotgun/doom/get_skill_spread(var/mob/living/L)
	return max(0,0.04 - (0.08 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/doom/get_base_spread()
	return 0.1