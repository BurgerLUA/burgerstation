/obj/item/weapon/ranged/bullet/revolver/sweep
	name = "\improper 12g Station Sweeper shotgun"
	desc = "Clean the station with one easy trick!"
	desc_extended = "An oddly designed semi-automatic shotgun with its own internal revolving magazine. The trigger pull is quite stiff and the recoil is even worse. Reloading requires manual removal of spent shells as there is no atuomatic shell eject system."
	icon = 'icons/obj/item/weapons/ranged/shotgun/nanotrasen/sweep.dmi'
	icon_state = "inventory"
	value = 400

	company_type = "NanoTrasen"

	tier = 2

	shoot_delay = 2

	automatic = FALSE

	bullet_count_max = 12

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	size = SIZE_3
	weight = 12

	bullet_length_min = 76
	bullet_length_best = 76.2
	bullet_length_max = 76.4

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19

	heat_max = 0.05

	open = TRUE //Starts open.

	can_shoot_while_open = TRUE

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = TRUE,
		/obj/item/attachment/stock_mod/reinforced_stock = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,



		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 17 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 26 - 16
	attachment_undermount_offset_y = 17 - 16

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.25
	movement_spread_base = 0.02

/obj/item/weapon/ranged/bullet/revolver/sweep/get_base_spread()
	return 0.15

/obj/item/weapon/ranged/bullet/revolver/sweep/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/revolver/sweep/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/revolver/sweep/click_self(var/mob/caller)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	rotate_cylinder(-1)
	caller?.to_chat(span("notice","You rotate the cylinder backwards."))
	return TRUE