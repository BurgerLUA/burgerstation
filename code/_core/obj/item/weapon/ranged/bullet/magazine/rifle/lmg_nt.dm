/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt
	name = "\improper 7.62mm H-LMG"
	desc = "What's betweeen you and 100 Syndicate? This LMG."
	desc_extended = "An extremely pricy 7.62mm Light Machine Gun that was originally inteded for use in mounted placements is now available for use in combat situations."
	icon = 'icons/obj/item/weapons/ranged/rifle/nanotrasen/762_lmg.dmi'
	icon_state = "inventory"

	value = 4000

	tier = 2

	shoot_delay = 2.5

	automatic = TRUE

	damage_mod = 1.2

	shoot_sounds = list('sound/weapons/308/shoot_alt.ogg')

	can_wield = TRUE
	wield_only = TRUE

	heat_max = 0.06

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_4
	weight = 25

	ai_heat_sensitivity = 0.1

	dan_mode = TRUE

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
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 18 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 15 - 16

	inaccuracy_modifier = 1
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.2

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt/get_static_spread()
	return 0.015

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt/get_skill_spread(var/mob/living/L)
	return max(0,0.1 - (0.1 * L.get_skill_power(SKILL_RANGED)))