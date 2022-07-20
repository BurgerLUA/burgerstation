/obj/item/weapon/ranged/bullet/magazine/smg/thompson
	name = "\improper Solarian Typewriter"
	desc = "The space gangster's choice."
	desc_extended = "A rugged, battlescarred submachine gun from a bygone era. They don't make them like they used to."
	icon = 'icons/obj/item/weapons/ranged/smg/sol/45.dmi'
	icon_state = "inventory"
	value = 4200

	company_type = "Solarian"

	tier = 4

	damage_mod = 1
	inaccuracy_modifier = 1
	movement_inaccuracy_modifier = 0.5
	shoot_delay = 0.8

	automatic = TRUE

	firemodes = list("automatic","semi-automatic")

	shoot_sounds = list('sound/weapons/45/shoot.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 25

	dan_mode = TRUE

	heat_max = 0.1

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



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 15 - 7
	attachment_sight_offset_y = 19 - 15

	attachment_undermount_offset_x = 30 - 16
	attachment_undermount_offset_y = 17 - 16

/obj/item/weapon/ranged/bullet/magazine/smg/thompson/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/smg/thompson/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))



