/obj/item/weapon/ranged/bullet/magazine/rifle/semi
	name = "\improper 5.56 SA-AR"
	desc = "Bet you can't guess what SA-AR stands for."
	desc_extended = "A semi-automatic assault rifle designed for shooters who want to be precise with their shots, but don't want to shell out the extra credits for a high caliber rifle."
	icon = 'icons/obj/item/weapons/ranged/rifle/nanotrasen/556_4.dmi'
	icon_state = "inventory"
	value = 150

	shoot_delay = 2

	automatic = FALSE

	shoot_sounds = list('sound/weapons/223/shoot.ogg')

	can_wield = TRUE

	view_punch = 12



	size = SIZE_4
	weight = 10


	heat_per_shot = 0.06
	heat_max = 0.20

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

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

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 16 - 16

	dan_mode = TRUE


/obj/item/weapon/ranged/bullet/magazine/rifle/semi/get_static_spread()
	if(!wielded) return 0.2
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/semi/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))