/obj/item/weapon/ranged/bullet/magazine/pistol/overseer
	name = "\improper 12.7mm High-Power Auto"
	desc = "The \"Auto\" is for semiauto."
	desc_extended = "A very powerful semiautomatic pistol designed for high ranking NanoTrasen commanders. The bulkiness of the pistol rivals submachine guns."
	icon = 'icons/obj/item/weapons/ranged/pistol/12mm_nt.dmi'
	icon_state = "inventory"
	value = 700

	tier = 2

	shoot_delay = 3

	automatic = FALSE

	movement_spread_base = 0.006
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.025

	shoot_sounds = list('sound/weapons/12/shoot.ogg')

	can_wield = FALSE

	size = SIZE_2
	weight = 7

	heat_max = 0.08

	bullet_length_min = 27
	bullet_length_best = 33
	bullet_length_max = 34

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

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

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 20 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 24 - 16
	attachment_undermount_offset_y = 12 - 16

/obj/item/weapon/ranged/bullet/magazine/pistol/overseer/get_static_spread()
	return 0.002

/obj/item/weapon/ranged/bullet/magazine/pistol/overseer/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/pistol/overseer/mod
	name = "\improper 12.7mm High-Power Auto MOD"
	desc = "The \"Auto\" is for semiauto."
	desc_extended = "A prototype of the High-Power Auto commonly seen in the hands of NanoTrasen commanders. This variant is made with higher quality parts and is commonly used by mercenaries."
	icon = 'icons/obj/item/weapons/ranged/pistol/12mm_nt_proto.dmi'
	icon_state = "inventory"
	value = 2000

	tier = 3
	shoot_delay = 2

	heat_max = 0.05

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,

		/obj/item/attachment/sight/laser_sight = FALSE,
		/obj/item/attachment/sight/quickfire_adapter = FALSE,
		/obj/item/attachment/sight/red_dot = FALSE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = FALSE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 28 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 18 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 21 - 16
	attachment_undermount_offset_y = 14 - 16



/obj/item/weapon/ranged/bullet/magazine/pistol/overseer/mod/silenced/Generate()

	. = ..()

	attachment_barrel = new/obj/item/attachment/barrel/suppressor(src)