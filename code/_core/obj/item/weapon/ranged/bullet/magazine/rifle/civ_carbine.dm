/obj/item/weapon/ranged/bullet/magazine/rifle/civ_carbine
	name = "\improper 5.56mm BP-SOL"
	desc = "A taste of SOL weaponry."
	desc_extended = "An older version of a carbine. Despite its age, many PMCs consider this carbine superior as it doesn't have any firerate limiters, allowing it to fire 600 rounds per second."
	icon = 'icons/obj/item/weapons/ranged/rifle/556_carbine.dmi'
	icon_state = "inventory"
	value = 150

	shoot_delay = 1.5

	automatic = TRUE

	shoot_sounds = list('sound/weapons/223/shoot_alt.ogg')

	can_wield = FALSE

	view_punch = 10



	size = SIZE_3
	weight = 10


	heat_per_shot = 0.04
	heat_max = 0.08

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

	firing_pin = /obj/item/firing_pin/electronic/iff/deathsquad


/obj/item/weapon/ranged/bullet/magazine/rifle/civ_carbine/get_static_spread()
	return 0.0075

/obj/item/weapon/ranged/bullet/magazine/rifle/civ_carbine/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.02 - (0.06 * L.get_skill_power(SKILL_RANGED)))