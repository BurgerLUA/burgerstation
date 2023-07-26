/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m739
	name = "\improper M739 Light Machine Gun"
	desc = "What's betweeen you and 100 Unggoys? This LMG."
	desc_extended = "Standard-issue squad automatic weapon, designed for use in heavy engagements. Takes 7.62mm calibre ordinary and box type magazines."
	icon = 'icons/obj/item/weapons/ranged/rifle/halo/m739.dmi'
	icon_state = "inventory"

	company_type = "UNSC"

	tier_type = "heavy weapon"

	value = 4000

	tier = 2

	shoot_delay = 1.8

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

	dan_mode = FALSE

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

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 19 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 15 - 16

	inaccuracy_modifier = 1
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.2

	rarity = RARITY_UNCOMMON

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m739/get_static_spread()
	return 0.0075

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m739/get_skill_spread(var/mob/living/L)
	return max(0,0.1 - (0.1 * L.get_skill_power(SKILL_RANGED)))