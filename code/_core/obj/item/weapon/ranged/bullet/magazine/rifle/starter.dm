/obj/item/weapon/ranged/bullet/magazine/rifle/starter
	name = "\improper 4.6x30mm FNG"
	desc = ""
	desc_extended = "An extremely lightweight, cheap and near recoiless combat rifle designed for new trainees to get some hands-on experience with firearms."
	icon = 'icons/obj/item/weapons/ranged/rifle/nanotrasen/starter.dmi'
	icon_state = "inventory"
	value = 400

	tier = 0

	shoot_delay = 2.5

	damage_mod = 1

	automatic = TRUE

	firemodes = list("automatic","burst","semi-automatic")

	shoot_sounds = list('sound/weapons/46/shoot_light.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 10

	heat_max = 0.05

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

	ai_heat_sensitivity = 1

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
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 17 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 18 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 15 - 16

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0.75
	movement_spread_base = 0.0075

	dan_mode = TRUE

/obj/item/weapon/ranged/bullet/magazine/rifle/starter/get_static_spread()
	return 0.0015

/obj/item/weapon/ranged/bullet/magazine/rifle/starter/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.05 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/starter/equipped/Generate()

	attachment_undermount = new /obj/item/attachment/undermount/vertical_grip(src)
	INITIALIZE(attachment_undermount)
	GENERATE(attachment_undermount)
	FINALIZE(attachment_undermount)

	attachment_barrel = new /obj/item/attachment/barrel/compensator(src)
	INITIALIZE(attachment_barrel)
	GENERATE(attachment_barrel)
	FINALIZE(attachment_barrel)

	. = ..()