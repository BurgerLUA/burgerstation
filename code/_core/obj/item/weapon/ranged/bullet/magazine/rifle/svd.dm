/obj/item/weapon/ranged/bullet/magazine/rifle/svd
	name = "\improper 7.62x54mmR SVD Dragunov"
	desc = "For when you want to spread communism at an extended range."
	desc_extended = "Originally developed in 1958 and still used as the primary Designated Marskman weapon pretty much everywhere, proving the superiority of Soviet Engineering."
	icon = 'icons/obj/item/weapons/ranged/rifle/762_snipe.dmi'
	icon_state = "inventory"
	value = 1800

	shoot_delay = 6

	automatic = FALSE

	damage_mod = 1.3

	shoot_sounds = list('sound/weapons/russia/svd.ogg')

	can_wield = TRUE
	wield_only = TRUE

	size = SIZE_5
	weight = 15

	heat_max = 0.07

	bullet_length_min = 46
	bullet_length_best = 54
	bullet_length_max = 58

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_4

	ai_heat_sensitivity = 2

	zoom_mul = 2

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 12 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 17 - 16

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.07

	firing_pin = /obj/item/firing_pin/electronic/iff/revolutionary

/obj/item/weapon/ranged/bullet/magazine/rifle/svd/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/svd/get_skill_spread(var/mob/living/L)
	return max(0,0.002 - (0.003 * L.get_skill_power(SKILL_RANGED)))