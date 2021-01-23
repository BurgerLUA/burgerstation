/obj/item/weapon/ranged/bullet/revolver/nagant
	name = "\improper 7.62x38mmR Nagant Revolver"
	desc = "A dusty old revolver."
	desc_extended = "The Nagant is difficult to use, but it pays off in durability and reliability."
	icon = 'icons/obj/item/weapons/ranged/revolver/762.dmi'
	icon_state = "inventory"

	shoot_delay = 2

	automatic = FALSE

	bullet_count_max = 7

	insert_limit = 7

	view_punch = 3

	shoot_sounds = list('sound/weapons/revolver_light/revolver.ogg')



	size = SIZE_3
	weight = 8


	bullet_length_min = 36
	bullet_length_best = 38
	bullet_length_max = 40

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7


	heat_per_shot = 0.03
	heat_max = 0.1

	value = 120

	open = TRUE //Starts open.

	can_shoot_while_open = TRUE

	inaccuracy_modifer = 0.25

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,

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
	attachment_barrel_offset_y = 21 - 16

	attachment_sight_offset_x = 14 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 28 - 16
	attachment_undermount_offset_y = 19 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/revolutionary

/obj/item/weapon/ranged/bullet/revolver/nagant/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/revolver/nagant/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.02 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/revolver/nagant/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	rotate_cylinder(-1)
	caller?.to_chat(span("notice","You rotate the cylinder backwards."))
	return TRUE