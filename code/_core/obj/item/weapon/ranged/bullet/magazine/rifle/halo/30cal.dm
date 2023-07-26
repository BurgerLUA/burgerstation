/obj/item/weapon/ranged/bullet/magazine/rifle/halo/cal30
	name = "\improper 7.62 Caliber Light Machine Gun"
	desc = "Atatatatatatata."
	desc_extended = "A light machine gun made by isurrection forces."
	icon = 'icons/obj/item/weapons/ranged/rifle/halo/30cal.dmi'
	icon_state = "inventory"
	value = 3000

	company_type = "United Rebel Front"

	tier_type = "heavy weapon"

	tier = 2

	shoot_delay = 1.3

	automatic = TRUE

	damage_mod = 1.1

	shoot_sounds = list(
	'sound/weapons/halo/unsc/lmg/chaingun_fire_h3_1.wav',
	'sound/weapons/halo/unsc/lmg/chaingun_fire_h3_2.wav',
	'sound/weapons/halo/unsc/lmg/chaingun_fire_h3_3.wav',
	'sound/weapons/halo/unsc/lmg/chaingun_fire_h3_4.wav',
	'sound/weapons/halo/unsc/lmg/chaingun_fire_h3_5.wav')

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

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 18 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 26 - 16
	attachment_undermount_offset_y = 15 - 16

	dan_mode = FALSE

	inaccuracy_modifier = 1
	movement_inaccuracy_modifier = 0.5
	movement_spread_base = 0.1

	rarity = RARITY_UNCOMMON

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/cal30/get_static_spread()
	return 0.0075

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/cal30/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.02 - (0.06 * L.get_skill_power(SKILL_RANGED)))