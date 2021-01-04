/obj/item/weapon/ranged/bullet/pump/shotgun/lever
	name = "12g lever-action shotgun"
	desc = "Git off my property!"
	desc_extended = "A lever action shotgun. Its lightweight, long-barrel design makes it more accurate than most shotguns, but fires slower. The weapon of choice for Space Farmers."
	icon = 'icons/obj/item/weapons/ranged/shotgun/lever_action.dmi'
	icon_state = "inventory"

	shoot_delay = 7

	automatic = FALSE

	bullet_count_max = 4

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	view_punch = 18



	size = SIZE_4
	weight = 10

	value = 120

	action_name = "work"

	heat_per_shot = 0.03
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
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 12 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 30 - 16
	attachment_undermount_offset_y = 18 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/deathsquad

/obj/item/weapon/ranged/bullet/pump/shotgun/lever/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/bullet/pump/shotgun/lever/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/lever/get_base_spread()
	return 0.05