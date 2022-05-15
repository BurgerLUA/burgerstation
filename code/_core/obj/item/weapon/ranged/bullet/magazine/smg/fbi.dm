/obj/item/weapon/ranged/bullet/magazine/smg/fbi
	name = ".45 NT-FBI"
	desc = "FBI, open up!"
	desc_extended = "The heavy kick of this SMG is only somewhat offset by its advanced recoil compensation mechanism. Perfect for when you need the power of a Magnum revolver in full-auto."
	icon = 'icons/obj/item/weapons/ranged/smg/nanotrasen/45.dmi'
	icon_state = "inventory"
	value = 1600

	tier = 2

	shoot_delay = 1.3

	automatic = TRUE

	shoot_sounds = list('sound/weapons/10/shoot.ogg')

	firemodes = list("automatic","burst","semi-automatic")

	can_wield = TRUE

	size = SIZE_3
	weight = 8

	heat_max = 0.07

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

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



		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 30 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 17 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 16 - 16

	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.25
	movement_spread_base = 0.015


/obj/item/weapon/ranged/bullet/magazine/smg/fbi/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/smg/fbi/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.03 * L.get_skill_power(SKILL_RANGED)))