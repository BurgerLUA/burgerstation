/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre
	name = "\improper 12.7mm Sabre"
	desc = "12.7mm Sabre Pistol"
	desc_extended = "A very powerful semiautomatic pistol commonly used by high ranking Syndicate Operatives. The stopping power rivals the .50 Eagle guns."
	icon = 'icons/obj/item/weapons/ranged/pistol/12mm.dmi'
	icon_state = "inventory"
	value = 1100

	tier = 2
	shoot_delay = 2.5

	automatic = FALSE

	movement_spread_base = 0.005
	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.75

	shoot_sounds = list('sound/weapons/12/shoot.ogg')

	can_wield = FALSE

	size = SIZE_2
	weight = 6

	heat_max = 0.09

	bullet_length_min = 27
	bullet_length_best = 33
	bullet_length_max = 34

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

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

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 24 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 23 - 16
	attachment_undermount_offset_y = 17 - 16


/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre/get_static_spread()
	return 0.0025

/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/pistol/high_calibre/mod
	name = "\improper 12.7mm Sabre MOD"
	icon = 'icons/obj/item/weapons/ranged/pistol/12mm_mod.dmi'
	desc_extended = "A modded variant very powerful semiautomatic pistol commonly used by the most elite high ranking Syndicate Operatives. \
	It is said that it is easier to become an elite syndicate operative than it is to actually obtain this weapon through other means."

	shoot_delay = 2

	heat_max = 0.12

	value = 2400

	shoot_sounds = list('sound/weapons/12/shoot_mod.ogg')

	tier = 3