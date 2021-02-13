/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten
	name = "\improper T20mm Tungsten Carbine"
	desc = "Shoots movable rods."
	desc_extended = "A special NanoTrasen Research Team tungesten shooting carbine designed to rival the syndicate energy crossbow. This version shoots tungesten rods instead of energy bolts, is more cumbersome than the energy now, and honestly really doesn't have any resemblence the energy crossbow at all."
	icon = 'icons/obj/item/weapons/ranged/smg/tungsten.dmi'
	icon_state = "inventory"
	shoot_delay = 2
	view_punch = 4
	shoot_sounds = list('sound/weapons/223/shoot.ogg')

	heat_per_shot = 0.01
	heat_max = 0.03

	bullet_length_min = 15
	bullet_length_best = 20
	bullet_length_max = 25

	bullet_diameter_min = 4
	bullet_diameter_best = 5
	bullet_diameter_max = 6

	automatic = TRUE

	override_icon_state = TRUE

	size = SIZE_3
	weight = 8

	value = 300

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
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 22 - 16

	attachment_sight_offset_x = 23 - 16
	attachment_sight_offset_y = 23 - 16

	attachment_undermount_offset_x = 29 - 16
	attachment_undermount_offset_y = 17 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/deathsquad

/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten/update_icon()

	icon_state = initial(icon_state)

	if(stored_magazine)
		icon_state = "[icon_state]_[CEILING((length(stored_magazine.stored_bullets)/stored_magazine.bullet_count_max)*5, 1)]"

	return ..()

/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten/get_cock_sound(var/direction="both")
	return 'sound/weapons/gun/smg/smg_rack.ogg'