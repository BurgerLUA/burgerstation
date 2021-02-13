/obj/item/weapon/ranged/bullet/magazine/smg/fbi
	name = "10mm NT-FBI"
	desc = "FBI, open up!"
	desc_extended = "The heavy kick of this SMG is only somewhat offset by its advanced recoil compensation mechanism. Perfect for when you need the power of a Magnum revolver in full-auto."
	icon = 'icons/obj/item/weapons/ranged/smg/10mm.dmi'
	icon_state = "inventory"
	value = 350

	shoot_delay = 1.6

	automatic = TRUE

	shoot_sounds = list('sound/weapons/10/shoot.ogg')

	can_wield = FALSE

	view_punch = 6

	size = SIZE_3
	weight = 8

	heat_per_shot = 0.03
	heat_max = 0.09

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

	ai_heat_sensitivity = 0.5

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
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

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 30 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 24 - 16
	attachment_undermount_offset_y = 16 - 16


/obj/item/weapon/ranged/bullet/magazine/smg/fbi/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/smg/fbi/get_skill_spread(var/mob/living/L)
	if(!heat_current)
		return 0
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/smg/fbi/mod
	name = "10mm NT-FBI MK2"
	icon = 'icons/obj/item/weapons/ranged/smg/10mm_2.dmi'
	desc_extended = "The heavy kick of this SMG is only somewhat offset by its advanced recoil compensation mechanism. Perfect for when you need the power of a Magnum revolver in full-auto. This variant has a heavier design which helps with cooling."
	heat_per_shot = 0.02
	heat_max = 0.08
	view_punch = 4
	value = 650
	weight = 10
