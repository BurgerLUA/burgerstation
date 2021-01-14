/obj/item/weapon/ranged/bullet/magazine/rifle/pulse
	name = "\improper pulse rifle"
	desc = "The primary weapon of the space military."
	desc_extended = "A pricy and powerful magazine-fed pulse rifle that fires massive amounts of matter-destroying energy. Not for the lighthearted."
	icon = 'icons/obj/item/weapons/ranged/laser/pulse.dmi'
	icon_state = "inventory"
	value = 1500

	shoot_delay = 4

	automatic = FALSE

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

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 17 - 16

	dan_mode = TRUE

	override_icon_state = TRUE

	firing_pin = /obj/item/firing_pin/electronic/iff/deathsquad

/obj/item/weapon/ranged/bullet/magazine/rifle/pulse/get_static_spread()
	if(wielded) return 0
	return 0.15

/obj/item/weapon/ranged/bullet/magazine/rifle/pulse/update_icon()

	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		var/icon_num = CEILING(3*(length(M.stored_bullets)/M.bullet_count_max),1)
		icon_state = "[initial(icon_state)]_[icon_num]"
	else
		icon_state = "[initial(icon_state)]_open"

	return ..()
