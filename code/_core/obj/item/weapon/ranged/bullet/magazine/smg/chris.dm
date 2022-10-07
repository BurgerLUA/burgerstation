/obj/item/weapon/ranged/bullet/magazine/smg/chris
	name = "\improper 9mm Bearing SMG"
	desc = "A submachinegun carbine that takes pistol mags? Weird, but okay."
	desc_extended = "A lightweight fast-firing Syndicate tactical submachinegun carbine designed to send a lot of bullets down-range at once. Uses 9mm pistol magazines."
	icon = 'icons/obj/item/weapons/ranged/smg/syndicate/9mm_2.dmi'
	icon_state = "inventory"
	value = 2800

	company_type = "Syndicate"

	tier = 4

	damage_mod = 1
	inaccuracy_modifier = 1
	movement_inaccuracy_modifier = 0.5
	shoot_delay = 0.75

	automatic = TRUE

	firemodes = list("automatic","semi-automatic")

	shoot_sounds = list('sound/weapons/45/shoot.ogg')

	can_wield = TRUE

	size = SIZE_3
	weight = 14

	dan_mode = TRUE

	heat_max = 0.09

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

	bullet_length_min = 18
	bullet_length_best = 19
	bullet_length_max = 20

	ai_heat_sensitivity = 0.5

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
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

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 17 - 7
	attachment_sight_offset_y = 20 - 15

	attachment_undermount_offset_x = 28 - 16
	attachment_undermount_offset_y = 16 - 16

/obj/item/weapon/ranged/bullet/magazine/smg/chris/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/smg/chris/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))



