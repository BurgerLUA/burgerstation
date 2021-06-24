/obj/item/weapon/ranged/bullet/magazine/smg/tactical
	name = "\improper 10mm MTAC"
	desc = "Precision in the palms of your hands."
	desc_extended = "A decently accurate full auto SMG designed to take down targets at medium ranges while still being able to fight in close range."
	icon = 'icons/obj/item/weapons/ranged/smg/10mm_3.dmi'
	icon_state = "inventory"
	value = 1400

	shoot_delay = 2

	automatic = TRUE

	firemodes = list("semi-automatic","automatic","burst")

	shoot_sounds = list('sound/weapons/45/shoot.ogg')

	can_wield = TRUE

	size = SIZE_2
	weight = 10

	heat_max = 0.03

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

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
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 14 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 17 - 16



	dan_mode = TRUE

	inaccuracy_modifier = 0.75
	movement_spread_base = 0.015

	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.25

/obj/item/weapon/ranged/bullet/magazine/smg/tactical/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/smg/tactical/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/magazine/smg/tactical/equipped/Generate()

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

	update_attachment_stats()
	update_sprite()



/obj/item/weapon/ranged/bullet/magazine/smg/tactical/nt
	icon = 'icons/obj/item/weapons/ranged/smg/10mm_3_nt.dmi'



