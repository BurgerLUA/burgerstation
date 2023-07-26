/obj/item/weapon/ranged/bullet/magazine/rifle/halo/ma37
	name = "\improper MA37 Assault Rifle"
	desc = "Space age technology calls for space age guns. This should easily rip someone a new hole."
	desc_extended = "Standard-issue service rifle of the UNSC Marines. Has an inbuilt underbarrel flashlight. Takes 7.62mm calibre magazines."
	icon = 'icons/obj/item/weapons/ranged/rifle/halo/ma37.dmi'
	icon_state = "inventory"
	value = 1100

	company_type = "UNSC"

	tier = 1

	shoot_delay = 1.8

	automatic = TRUE

	firemodes = list("automatic","semi-automatic")

	shoot_sounds = list(
	'sound/weapons/halo/unsc/assault_rifle/19103_b.wav',
	'sound/weapons/halo/unsc/assault_rifle/19203_b.wav',
	'sound/weapons/halo/unsc/assault_rifle/19204_b.wav')

	can_wield = TRUE

	size = SIZE_4
	weight = 13

	heat_max = 0.05

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
		/obj/item/attachment/undermount/vertical_grip = FALSE,
		/obj/item/attachment/undermount/gun/grenade_launcher = FALSE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 17 - 16

	dan_mode = TRUE

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.75
	movement_spread_base = 0.02

	rarity = RARITY_COMMON


/obj/item/weapon/ranged/bullet/magazine/rifle/halo/ma37/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/ma37/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)))