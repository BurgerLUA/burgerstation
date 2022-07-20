/obj/item/weapon/ranged/bullet/magazine/smg/smart
	name = "\improper 4.6x30mm Smart SMG"
	desc = "Now that's smarts!"
	desc_extended = "A Solarian protoype SMG that uses expensive smart-microchip heat-seeking guided bullets to assist in idiots hitting targets. Has a tendency to actually still miss."
	icon = 'icons/obj/item/weapons/ranged/smg/sol/smart.dmi'
	icon_state = "inventory"
	value = 3000

	company_type = "Solarian"

	damage_mod = 1

	tier = 3

	automatic = TRUE
	can_wield = FALSE

	shoot_delay = 1
	burst_delay = 8
	max_bursts = 6

	firemodes = list("burst","semi-automatic")

	shoot_sounds = list('sound/weapons/smg_light/smg.ogg')

	heat_max = 0.1

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

	size = SIZE_3
	weight = 10

	ai_heat_sensitivity = 2

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
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

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 16 - 16

	inaccuracy_modifier = 2
	movement_inaccuracy_modifier = 0

/obj/item/weapon/ranged/bullet/magazine/smg/smart/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/smg/smart/get_skill_spread(var/mob/living/L)
	return max(0,0.04 - (0.04 * L.get_skill_power(SKILL_RANGED)))