/obj/item/weapon/ranged/bullet/magazine/rifle/groza
	name = "\improper 9x39mm OP14"
	desc = "Compact strength for a compact military."
	desc_extended = "A fast firing automatic bullpup assault rifle acts as a cheaper alternative to the AKSU Type-13. Ironically, 75% of its parts originate from the AKSU Type-13."
	icon = 'icons/obj/item/weapons/ranged/rifle/rev/939_smg.dmi'
	icon_state = "inventory"
	value = 1700

	company_type = "Slavic"

	tier = 2

	shoot_delay = 1.25

	damage_mod = 1.1

	automatic = TRUE

	firemodes = list("automatic","semi-automatic")

	shoot_sounds = list('sound/weapons/308/shoot_short.ogg') //Very-very lazy, will prolly change all gun sounds later with their respective ones from either stalker or stalkerbuild.

	can_wield = FALSE

	size = SIZE_3
	weight = 8

	heat_max = 0.15

	bullet_length_min = 38
	bullet_length_best = 39
	bullet_length_max = 40

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

	ai_heat_sensitivity = 1.5

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE
	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 20 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 24 - 16
	attachment_undermount_offset_y = 16 - 16

	dan_mode = TRUE

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0.25
	movement_spread_base = 0.005


/obj/item/weapon/ranged/bullet/magazine/rifle/groza/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/rifle/groza/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.03 * L.get_skill_power(SKILL_RANGED)))