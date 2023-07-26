/obj/item/weapon/ranged/bullet/magazine/smg/halo/covenant/needler
	name = "Type-33 Guided Munitions Launcher"
	desc = "Precision in the palms of your hands."
	desc_extended = "This weapon fire razor-sharp crystalline shards which can explode violently when embedded into targets."
	icon = 'icons/obj/item/weapons/ranged/smg/halo/needler.dmi'
	icon_state = "inventory"

	company_type = "Covenant"

	tier = 1

	value = 800

	shoot_delay = 1.3

	automatic = TRUE

	shoot_sounds = list(
	'sound/weapons/halo/covenant/needlefire11.wav',
	'sound/weapons/halo/covenant/needlefire12.wav',
	'sound/weapons/halo/covenant/needlefire13.wav')

	can_wield = FALSE
	dan_mode = FALSE
	size = SIZE_2
	weight = 8

	heat_max = 0.1

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	ai_heat_sensitivity = 0.5

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/charger/advanced = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = FALSE,
		/obj/item/attachment/stock_mod/reinforced_stock = FALSE,

		/obj/item/attachment/sight/laser_sight = FALSE,
		/obj/item/attachment/sight/quickfire_adapter = FALSE,
		/obj/item/attachment/sight/red_dot = FALSE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = FALSE,



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 27 - 16
	attachment_barrel_offset_y = 21 - 16

	attachment_sight_offset_x = 23 - 16
	attachment_sight_offset_y = 23 - 16

	attachment_undermount_offset_x = 24 - 16
	attachment_undermount_offset_y = 19 - 16

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0

	rarity = RARITY_COMMON


/obj/item/weapon/ranged/bullet/magazine/smg/halo/covenant/needler/get_static_spread()
	return 0.015

/obj/item/weapon/ranged/bullet/magazine/smg/halo/covenant/needler/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)))