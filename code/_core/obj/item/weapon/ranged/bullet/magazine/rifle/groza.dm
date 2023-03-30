/obj/item/weapon/ranged/bullet/magazine/rifle/groza
	name = "\improper 9x39mm BOX-14 bullpup rifle"
	desc = "Compact, surplus strength for a compact, surplus military."
	desc_extended = "A fast firing automatic bullpup assault rifle acts as a cheaper alternative to the AKSU Type-13, with some parts of the frame being made out of wood for reduced part cost. Ironically, 75% of its parts originate from the AKSU Type-13."
	icon = 'icons/obj/item/weapons/ranged/rifle/rev/939_bullpup.dmi'
	icon_state = "inventory"
	value = 1700

	company_type = "Slavic"

	tier = 2

	shoot_delay = 1

	damage_mod = 1.1

	automatic = TRUE

	firemodes = list("automatic","semi-automatic")

	shoot_sounds = list('sound/weapons/ranged/rifle/groza/shoot.ogg')

	can_wield = TRUE

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
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = TRUE,
		/obj/item/attachment/stock_mod/reinforced_stock = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE,
		/obj/item/attachment/undermount/gun/grenade_launcher = TRUE
	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 17 - 16

	attachment_sight_offset_x = 17 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 15 - 16

	dan_mode = TRUE

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0.25
	movement_spread_base = 0.005

	rarity = RARITY_UNCOMMON


/obj/item/weapon/ranged/bullet/magazine/rifle/groza/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/rifle/groza/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.03 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/groza/equipped/Generate()
	. = ..()
	attachment_undermount = /obj/item/attachment/undermount/vertical_grip
	attachment_undermount = new attachment_undermount(src)