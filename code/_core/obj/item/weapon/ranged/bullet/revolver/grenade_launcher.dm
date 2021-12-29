/obj/item/weapon/ranged/bullet/revolver/grenade_launcher
	name = "\improper Grenade Thumper"
	desc = "Blooper"
	desc_extended = "An old grenade launcher from a past era, uses 40mm grenades."
	icon = 'icons/obj/item/weapons/ranged/grenade_launcher.dmi'
	icon_state = "inventory"
	value = 1200

	tier = 1
	bypass_balance_check = TRUE

	shoot_delay = 20

	automatic = TRUE

	bullet_count_max = 1

	insert_limit = 1

	shoot_sounds = list('sound/weapons/grenade_launcher/thump.ogg')

	size = SIZE_4
	weight = 12

	bullet_length_min = 45
	bullet_length_best = 46
	bullet_length_max = 47

	bullet_diameter_min = 39
	bullet_diameter_best = 40
	bullet_diameter_max = 41

	heat_max = 0.18

	open = TRUE

	attachment_whitelist = list(
		/obj/item/attachment/sight/laser_sight = FALSE,
		/obj/item/attachment/sight/quickfire_adapter = FALSE,
		/obj/item/attachment/sight/red_dot = FALSE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = FALSE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 0 - 16
	attachment_barrel_offset_y = 0 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 0 - 16
	attachment_undermount_offset_y = 0 - 16



	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.04

/obj/item/weapon/ranged/bullet/revolver/grenade_launcher/get_base_spread()
	return 0.1

/obj/item/weapon/ranged/bullet/revolver/grenade_launcher/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/revolver/grenade_launcher/get_skill_spread(var/mob/living/L)
	return max(0,0.03 - (0.12 * L.get_skill_power(SKILL_RANGED)))