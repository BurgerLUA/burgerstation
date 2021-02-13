/obj/item/weapon/ranged/bullet/magazine/pistol/yarygin
	name = "\improper modified 9x19mm MP-443"
	desc = "Korobochka, horoni rebyat."
	desc_extended = "Russian-produced semiautomatic 9x19 pistol, a service weapon of the Russian army, special forces and other defense and law enforcement agencies. Comes with internal modification which allows it to shoot quick bursts of two bullets, similarly to AN-94."
	icon = 'icons/obj/item/weapons/ranged/pistol/yarygin.dmi'
	icon_state = "inventory"
	value = 150

	shoot_delay = 1.75
	view_punch = 4
	max_bursts = 2

	shoot_sounds = list('sound/weapons/10/shoot.ogg')

	can_wield = FALSE

	automatic = TRUE

	size = SIZE_1
	weight = 3


	heat_per_shot = 0.02
	heat_max = 0.18

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

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
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 24 - 16

	attachment_undermount_offset_x = 26 - 16
	attachment_undermount_offset_y = 14 - 16
	firing_pin = /obj/item/firing_pin/electronic/iff/revolutionary

/obj/item/weapon/ranged/bullet/magazine/pistol/yarygin/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/pistol/yarygin/get_skill_spread(var/mob/living/L)
	return max(0,0.04 - (0.06 * L.get_skill_power(SKILL_RANGED)))
