/obj/item/weapon/ranged/bullet/magazine/rifle/service
	name = "\improper 7.62mm SOL-14 Service Rifle"
	desc = "HOORAH!."
	desc_extended = "The SOL-14 is the battle rifle currently in service in the SolGov Army. It's occasionally seen in the hands of PMCs."
	icon = 'icons/obj/item/weapons/ranged/rifle/nanotrasen/762_2.dmi'
	icon_state = "inventory"
	value = 2200

	tier = 1

	shoot_delay = 4

	automatic = FALSE

	shoot_sounds = list('sound/weapons/308/shoot.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 14

	heat_max = 0.1

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	ai_heat_sensitivity = 1.5

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
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 28 - 16
	attachment_undermount_offset_y = 19 - 16

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.04

	dan_mode = TRUE

/obj/item/weapon/ranged/bullet/magazine/rifle/service/get_static_spread()
	return 0.0001

/obj/item/weapon/ranged/bullet/magazine/rifle/service/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.06 * L.get_skill_power(SKILL_RANGED)))