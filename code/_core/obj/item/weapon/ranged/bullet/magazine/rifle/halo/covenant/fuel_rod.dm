/obj/item/weapon/ranged/bullet/magazine/rifle/halo/covenant/fuel_rod
	name = "\improper Type-33 Light Anti-Armor Weapon"
	desc = "Just run from it."
	desc_extended = "The Type-33 Light Anti-Armor Weapon, more commonly known as the Fuel Rod Gun or Fuel Rod Cannon, is a Covenant shoulder-fired mortar/radiation weapon."
	icon = 'icons/obj/item/weapons/ranged/misc/halo/fuelrod.dmi'

	shoot_delay = SECONDS_TO_DECISECONDS(2)

	automatic = FALSE
	item_slot = SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK

	view_punch = TILE_SIZE - 1
	override_icon_state = TRUE

	shoot_sounds = list(
	'sound/weapons/covenant/flak_fire_h3_1.wav',
	'sound/weapons/covenant/flak_fire_h3_2.wav',
	'sound/weapons/covenant/flak_fire_h3_3.wav')

	can_wield = TRUE
	wield_only = TRUE

	size = SIZE_4
	weight = 12

	bullet_length_min = 46
	bullet_length_best = 46
	bullet_length_max = 47

	bullet_diameter_min = 40
	bullet_diameter_best = 41
	bullet_diameter_max = 42

	heat_per_shot = 0.09
	heat_max = 0.18

	value = 2300

	open = TRUE

	inaccuracy_modifer = 1

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/laser_charger/advanced = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,

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

	firing_pin = /obj/item/firing_pin/electronic/iff/covenant

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/covenant/fuel_rod/get_base_spread()
	return 0.1

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/covenant/fuel_rod/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/covenant/fuel_rod/get_skill_spread(var/mob/living/L)
	return max(0,0.03 - (0.12 * L.get_skill_power(SKILL_RANGED)))