/obj/item/weapon/ranged/bullet/magazine/rifle/m4
	name = "\improper 5.56mm M5A2"
	desc = "Made in Space America!"
	desc_extended = "A typical run of the mill assault rifle designed to quickly put down targets at medium to long ranges."
	icon = 'icons/obj/item/weapons/ranged/rifle/sol/standard.dmi'
	icon_state = "inventory"
	value = 1800

	tier = 2

	damage_mod = 1.15
	shoot_delay = 1.15

	automatic = TRUE

	firemodes = list("automatic","semi-automatic")

	shoot_sounds = list('sound/weapons/223/shoot_military.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 14

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ai_heat_sensitivity = 0.75

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
		/obj/item/attachment/sight/m4 = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 23 - 16
	attachment_undermount_offset_y = 16 - 16

	dan_mode = TRUE

	heat_max = 0.09

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.02

/obj/item/weapon/ranged/bullet/magazine/rifle/m4/get_static_spread()
	return 0.0075

/obj/item/weapon/ranged/bullet/magazine/rifle/m4/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/magazine/rifle/m4/Generate()
	. = ..()
	attachment_sight = new /obj/item/attachment/sight/m4(src)
	INITIALIZE(attachment_sight)
	GENERATE(attachment_sight)
	FINALIZE(attachment_sight)
