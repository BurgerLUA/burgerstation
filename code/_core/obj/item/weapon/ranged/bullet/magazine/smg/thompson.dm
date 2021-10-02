/obj/item/weapon/ranged/bullet/magazine/smg/thompson
	name = "M1919 Annihilator"
	desc = "The Thompson. Annihilator, Chicago Typewriter, Tommygun."
	desc_extended = "A rugged, battlescarred submachine gun from a bygone era."
	icon = 'icons/obj/item/weapons/ranged/smg/thompson.dmi'
	icon_state = "inventory"
	value = 4200

	tier = 3

	shoot_delay = 1

	automatic = TRUE

	firemodes = list("burst","automatic","semi-automatic")

	shoot_sounds = list('sound/weapons/45/shoot.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 25

	dan_mode = TRUE

	heat_max = 0.06

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	ai_heat_sensitivity = 0.5

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE, // more immoral than BDSM to put this on the thompson
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = FALSE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 5 - 7
	attachment_sight_offset_y = 18 - 15

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 17 - 16

	inaccuracy_modifier = 2 // i hope you like grinding ranged
	movement_inaccuracy_modifier = 0.5
	movement_spread_base = 0.2

/obj/item/weapon/ranged/bullet/magazine/smg/thompson/get_static_spread()
	return 0.04

/obj/item/weapon/ranged/bullet/magazine/smg/thompson/get_skill_spread(var/mob/living/L)
	return max(0,0.2 - (0.1 * L.get_skill_power(SKILL_RANGED)))



