/obj/item/weapon/ranged/bullet/magazine/rifle/marksman
	name = "\improper .308 AR-M"
	desc = "Vanilla, but still powerful."
	desc_extended = "The .308 Mauler Marksman Rifle is THE dmr for private military corporations. Easy to use, accurate, and comes only in semi-automatic to train those recruits not to waste ammo."
	icon = 'icons/obj/item/weapons/ranged/rifle/syndicate/308.dmi'
	icon_state = "inventory"
	value = 3750

	tier = 2

	firemodes = list("automatic","semi-automatic")

	shoot_delay = 2.75

	automatic = TRUE

	shoot_sounds = list('sound/weapons/308/shoot.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 12

	heat_max = 0.15

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	ai_heat_sensitivity = 1.5

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
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 14 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 17 - 16



	inaccuracy_modifier = 0.35
	movement_inaccuracy_modifier = 1.1
	movement_spread_base = 0.025


/obj/item/weapon/ranged/bullet/magazine/rifle/marksman/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/marksman/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/magazine/rifle/marksman/mod
	name = "\improper .308 Marksman Rifle MOD"
	icon = 'icons/obj/item/weapons/ranged/rifle/syndicate/308_mod.dmi'

	heat_max = 0.4

	size = SIZE_3
	weight = 8

	value = 4000

/obj/item/weapon/ranged/bullet/magazine/rifle/marksman/mod/get_static_spread()
	return 0.05