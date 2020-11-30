/obj/item/weapon/ranged/bullet/magazine/rifle/dmca
	name = "\improper 4.6x30mm DMCA"
	desc = "Takedown your foes with this DMCA!"
	desc_extended = "The 4.6x30mm DMCA is an extremely robust automatic weapon capable of sending a volley of penetrating small arms."
	icon = 'icons/obj/item/weapons/ranged/rifle/dmca.dmi'
	icon_state = "inventory"
	value = 400

	shoot_delay = 0.5
	burst_delay = 5
	max_bursts = 5

	automatic = TRUE

	shoot_sounds = list('sound/weapons/46/shoot.ogg')

	can_wield = TRUE

	view_punch = 4

	size = SIZE_4
	weight = 25

	heat_per_shot = 0.01
	heat_max = 0.06

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

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
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 17 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 28 - 16
	attachment_undermount_offset_y = 15 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/space_cop

	dan_mode = TRUE


/obj/item/weapon/ranged/bullet/magazine/rifle/dmca/get_static_spread()
	if(!wielded) return 0.2
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/dmca/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))