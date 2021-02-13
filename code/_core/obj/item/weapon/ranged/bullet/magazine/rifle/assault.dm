/obj/item/weapon/ranged/bullet/magazine/rifle/assault
	name = "\improper .308 BR-NT"
	desc = "Space age technology calls for space age guns. This should easily rip someone a new hole."
	desc_extended = "A .308 chambered mother-of-all-battle-rifles (MOABR) developed by the NanoTrasen research team to rival the syndicate .308 marksman rifle, but without the slow shooting speed. Nicknamed the \"Arn't\" for what the enemy will be when an entire magazine is fired into them, and also because it's not an AR."
	icon = 'icons/obj/item/weapons/ranged/rifle/308_adv.dmi'
	icon_state = "inventory"
	value = 500

	shoot_delay = 2

	automatic = TRUE

	shoot_sounds = list('sound/weapons/308/shoot.ogg')

	can_wield = TRUE

	view_punch = 10

	size = SIZE_4
	weight = 20

	heat_per_shot = 0.04
	heat_max = 0.08

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

	firing_pin = /obj/item/firing_pin/electronic/iff/deathsquad

/obj/item/weapon/ranged/bullet/magazine/rifle/assault/get_static_spread()
	if(!wielded) return 0.2
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/rifle/assault/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.02 - (0.06 * L.get_skill_power(SKILL_RANGED)))

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

	update_attachment_stats()
	update_sprite()

	return .