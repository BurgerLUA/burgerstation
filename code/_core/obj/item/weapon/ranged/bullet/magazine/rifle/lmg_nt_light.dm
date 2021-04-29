/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt_light
	name = "\improper 5.56mm NT-LMG-L"
	desc = "A lighter light machine gun."
	desc_extended = ""
	icon = 'icons/obj/item/weapons/ranged/rifle/nanotrasen/556_6.dmi'
	icon_state = "inventory"
	value = 3500

	shoot_delay = 2

	automatic = TRUE

	damage_mod = 1.1

	shoot_sounds = list('sound/weapons/223/shoot_alt.ogg')

	can_wield = TRUE
	wield_only = TRUE

	size = SIZE_4
	weight = 14

	heat_max = 0.06

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ai_heat_sensitivity = 0.5

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
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 21 - 16

	attachment_sight_offset_x = 18 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 29 - 16
	attachment_undermount_offset_y = 16 - 16



	dan_mode = TRUE

	inaccuracy_modifier = 1
	movement_inaccuracy_modifier = 0.5
	movement_spread_base = 0.1

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt_light/get_static_spread()
	return 0.0075

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt_light/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.02 - (0.06 * L.get_skill_power(SKILL_RANGED)))