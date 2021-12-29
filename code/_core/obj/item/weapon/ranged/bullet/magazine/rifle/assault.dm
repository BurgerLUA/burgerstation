/obj/item/weapon/ranged/bullet/magazine/rifle/assault
	name = "\improper .308 Prototype MOAR"
	desc = "Space age technology calls for space age guns. This should easily rip someone a new hole."
	desc_extended = "A .308 chambered mother-of-all-battle-rifles (MOABR) developed by the Solarian research team for space battles."
	icon = 'icons/obj/item/weapons/ranged/rifle/sol/308_advanced.dmi'
	icon_state = "inventory"
	value = 6000

	tier = 2

	shoot_delay = 2.5

	damage_mod = 1.2

	automatic = TRUE

	firemodes = list("burst","automatic","semi-automatic")

	shoot_sounds = list('sound/weapons/308/shoot.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 20

	heat_max = 0.1

	bullet_length_min = 46
	bullet_length_best = 51
	bullet_length_max = 52

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	ai_heat_sensitivity = 0.75

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
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 22 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 24 - 16
	attachment_undermount_offset_y = 14 - 16

	inaccuracy_modifier = 0.35
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.01

/obj/item/weapon/ranged/bullet/magazine/rifle/assault/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/rifle/assault/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/assault/equipped/Generate()

	. = ..()

	if(prob(50))
		attachment_barrel = pick(\
			/obj/item/attachment/barrel/charger,\
			/obj/item/attachment/barrel/compensator,\
			/obj/item/attachment/barrel/extended,\
			/obj/item/attachment/barrel/gyro,\
			/obj/item/attachment/barrel/suppressor\
		)
	if(prob(50))
		attachment_sight = pick(\
			/obj/item/attachment/sight/laser_sight,\
			/obj/item/attachment/sight/quickfire_adapter,\
			/obj/item/attachment/sight/red_dot\
		)

	if(prob(50))
		attachment_undermount = pick(\
			/obj/item/attachment/undermount/angled_grip,\
			/obj/item/attachment/undermount/bipod,\
			/obj/item/attachment/undermount/burst_adapter,\
			/obj/item/attachment/undermount/vertical_grip\
		)

	if(attachment_barrel) attachment_barrel = new attachment_barrel(src)
	if(attachment_sight) attachment_sight = new attachment_sight(src)
	if(attachment_undermount) attachment_undermount = new attachment_undermount(src)