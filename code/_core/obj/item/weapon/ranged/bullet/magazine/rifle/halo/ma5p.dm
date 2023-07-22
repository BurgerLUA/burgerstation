/*
Do not, for the love of god, use this anywhere.
It's a shitty HaloStation insert.
*/
/obj/item/weapon/ranged/bullet/magazine/rifle/halo/ma5p
	name = "MA5P Laser Rifle"
	desc = "Pew pew pew!"
	desc_extended = "A modular model of laser rifle, capable of using different crystals to shoot beams with different effects. This one is the standard beam."
	icon = 'icons/obj/item/weapons/ranged/rifle/halo/ma5p.dmi'
	value = 1500

	shoot_delay = 4

	automatic = TRUE

	shoot_sounds = list('sound/weapons/pulse/pulse.ogg')

	can_wield = TRUE

	view_punch = 31

	size = SIZE_4
	weight = 20

	heat_per_shot = 0.05
	heat_max = 0.1

	bullet_length_min = 52
	bullet_length_best = 52
	bullet_length_max = 52

	bullet_diameter_min = 13
	bullet_diameter_best = 13
	bullet_diameter_max = 13

	ai_heat_sensitivity = 0.75

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/laser_charger/advanced = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,

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

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 17 - 16

	override_icon_state = TRUE

	firing_pin = /obj/item/firing_pin/electronic/iff/nanotrasen

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/ma5p/get_static_spread()
	if(wielded) return 0
	return 0.15