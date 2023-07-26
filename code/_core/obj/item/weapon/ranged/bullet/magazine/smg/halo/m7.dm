/obj/item/weapon/ranged/bullet/magazine/smg/halo/m7
	name = "M7 submachine gun"
	desc = "Precision in the palms of your hands."
	desc_extended = "The M7/Caseless Submachine Gun is a fully automatic close quarters infantry and special operations weapon. Takes 5mm calibre magazines."
	icon = 'icons/obj/item/weapons/ranged/smg/halo/m7.dmi'
	icon_state = "inventory"
	value = 1600

	company_type = "UNSC"

	tier = 2

	shoot_delay = 1.3

	automatic = TRUE

	shoot_sounds = list(
	'sound/weapons/halo/unsc/m7/m7_fire1.wav',
	'sound/weapons/halo/unsc/m7/m7_fire2.wav',
	'sound/weapons/halo/unsc/m7/m7_fire3.wav'
	)

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
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = FALSE,
		/obj/item/attachment/stock_mod/reinforced_stock = FALSE,

		/obj/item/attachment/sight/laser_sight = FALSE,
		/obj/item/attachment/sight/quickfire_adapter = FALSE,
		/obj/item/attachment/sight/red_dot = FALSE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = FALSE,



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
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

	rarity = RARITY_UNCOMMON


/obj/item/weapon/ranged/bullet/magazine/smg/halo/m7/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/smg/halo/m7/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.03 * L.get_skill_power(SKILL_RANGED)))