/obj/item/weapon/ranged/bullet/magazine/rifle/rpk
	name = "\improper 5.45x39mm RPK-16"
	desc = "Killa's weapon of choice."
	desc_extended = "RPK-16 is a 5.45x39mm LMG. <br> Get me a better description writer pls or else I'll die of imagination't."
	icon = 'icons/obj/item/weapons/ranged/rifle/PKM.dmi' //it's rpk but icon is pkm but you don't worry I just fucked up.
	icon_state = "inventory"
	value = 650

	shoot_delay = 2

	shoot_sounds = list('sound/weapons/russia/abakan.ogg')

	can_wield = TRUE

	automatic = TRUE

	size = SIZE_5
	weight = 18

	heat_max = 1

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 5.4
	bullet_diameter_best = 5.45
	bullet_diameter_max = 5.46  //Just so people wouldn't load this gun with 5.56, would be really-really weird to do so - Stalkeros

	ai_heat_sensitivity = 1.5

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 22 - 15
	attachment_undermount_offset_y = 18 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/revolutionary

	inaccuracy_modifier = 1
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.1

/obj/item/weapon/ranged/bullet/magazine/rifle/rpk/get_static_spread()
	if(!wielded)
		return 0.16
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/rifle/rpk/get_skill_spread(var/mob/living/L)
	if(!heat_current)
		return 0
	return max(0,0.1 - (0.11 * L.get_skill_power(SKILL_RANGED)))