/obj/item/weapon/ranged/bullet/revolver/horse
	name = "\improper .45 HOL-Horse Revolver"
	desc = "Yeehaw chucklefucks."
	desc_extended = "A replica of a past relic, this double action revolver fires .45 pistol rounds. Not very practical, but at least you'll look cool using it."
	icon = 'icons/obj/item/weapons/ranged/revolver/45.dmi'
	icon_state = "inventory"

	shoot_delay = 1

	automatic = FALSE

	bullet_count_max = 6

	shoot_sounds = list('sound/weapons/revolver_light/revolver.ogg')

	view_punch = 4



	size = SIZE_1
	weight = 5


	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

	heat_per_shot = 0.02
	heat_max = 0.1

	value = 400

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

	attachment_barrel_offset_x = 28 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 14 - 16
	attachment_undermount_offset_y = 18 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/deathsquad

/obj/item/weapon/ranged/bullet/revolver/horse/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/revolver/horse/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/revolver/horse/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	rotate_cylinder(-1)
	caller?.to_chat(span("notice","You rotate the cylinder backwards."))
	return TRUE