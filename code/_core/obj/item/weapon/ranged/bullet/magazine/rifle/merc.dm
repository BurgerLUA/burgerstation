/obj/item/weapon/ranged/bullet/magazine/rifle/merc
	name = "\improper 5.56mm MGS-5 Assault Rifle"
	desc = "It can't be."
	desc_extended = "A very tactical semi automatic assault rifle used primarily by serious mercenaries that rivals NanoTrasen's SA-AR."
	icon = 'icons/obj/item/weapons/ranged/rifle/sol/merc.dmi'
	icon_state = "inventory"
	value = 3500

	tier = 2

	shoot_delay = 1.25
	damage_mod = 1

	automatic = FALSE

	firemodes = list("automatic","semi-automatic")

	shoot_sounds = list('sound/weapons/223/shoot.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 12

	heat_max = 0.1

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ai_heat_sensitivity = 0.5

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
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 23 - 16
	attachment_undermount_offset_y = 17 - 16

	dan_mode = TRUE



	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.5
	movement_spread_base = 0.02

/obj/item/weapon/ranged/bullet/magazine/rifle/merc/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/merc/get_skill_spread(var/mob/living/L)
	return max(0,0.03 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/merc/equipped/Generate()

	. = ..()

	attachment_barrel = /obj/item/attachment/barrel/suppressor

	if(prob(50))
		attachment_sight = pick(\
			/obj/item/attachment/sight/laser_sight,\
			/obj/item/attachment/sight/red_dot\
		)
	if(prob(50))
		attachment_undermount = pick(\
			/obj/item/attachment/undermount/angled_grip,\
			/obj/item/attachment/undermount/vertical_grip\
		)

	if(attachment_barrel) attachment_barrel = new attachment_barrel(src)
	if(attachment_sight) attachment_sight = new attachment_sight(src)
	if(attachment_undermount) attachment_undermount = new attachment_undermount(src)