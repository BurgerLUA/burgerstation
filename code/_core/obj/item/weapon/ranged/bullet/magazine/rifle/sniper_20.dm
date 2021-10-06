/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_20
	name = "\improper 20x117mm Anti-Material Rifle"
	desc = "Meant to fight agains tanks, but uh... you don't see any tanks around, do you?"
	desc_extended = "A fully fledged anti-material rifle designed to absolutely obliterate anything in its path. Use for taking down tanks, mechs, and ships with one or two hits."
	icon = 'icons/obj/item/weapons/ranged/rifle/sol/sniper_20.dmi'
	icon_state = "inventory"
	value = 12000

	tier = 5

	shoot_delay = 20

	automatic = FALSE

	damage_mod = 2

	shoot_sounds = list('sound/weapons/20/shoot.ogg')

	can_wield = TRUE
	wield_only = TRUE

	size = SIZE_7
	weight = 40

	heat_max = 0.1

	bullet_length_min = 116
	bullet_length_best = 117
	bullet_length_max = 117

	bullet_diameter_min = 19
	bullet_diameter_best = 20
	bullet_diameter_max = 20

	ai_heat_sensitivity = 4
	dan_mode = TRUE

	attachment_whitelist = list(
		/obj/item/attachment/stock/sniper_20 = TRUE,
		/obj/item/attachment/barrel/sniper_20 = TRUE,


		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/scope/massive = TRUE,
		/obj/item/attachment/sight/scope/massive/sniper_20 = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32
	attachment_barrel_offset_y = 0

	attachment_sight_offset_x = 7 - 16
	attachment_sight_offset_y = 17 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 14 - 16

	attachment_stock_offset_x = -32
	attachment_stock_offset_y = 0

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 2.5

	movement_spread_base = 0.3

	dan_mode = TRUE

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_20/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_20/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_20/Generate()

	attachment_stock = new /obj/item/attachment/stock/sniper_20(src)
	INITIALIZE(attachment_stock)
	GENERATE(attachment_stock)
	FINALIZE(attachment_stock)

	attachment_barrel = new /obj/item/attachment/barrel/sniper_20(src)
	INITIALIZE(attachment_barrel)
	GENERATE(attachment_barrel)
	FINALIZE(attachment_barrel)

	attachment_sight = new /obj/item/attachment/sight/scope/massive/sniper_20(src)
	INITIALIZE(attachment_sight)
	GENERATE(attachment_sight)
	FINALIZE(attachment_sight)

	. = ..()

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_20/get_cock_sound(var/direction="both")
	return 'sound/weapons/20/bolt.ogg'