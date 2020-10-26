/obj/item/weapon/ranged/bullet/magazine/pistol/deagle
	name = ".50 Silver Eagle"
	desc = "Shiny!"
	desc_extended = "A proudly American made and designed<sup>\[citation needed\]</sup> 50 calibre pistol for the most elite of commanders. This one is silver plated."
	icon = 'icons/obj/item/weapons/ranged/pistol/50.dmi'
	value = 170
	shoot_delay = 4
	shoot_sounds = list('sound/weapons/50/shoot.ogg')

	view_punch = 20

	size = SIZE_2
	weight = 6


	heat_per_shot = 0.06
	heat_max = 0.3

	bullet_length_min = 30
	bullet_length_best = 33
	bullet_length_max = 36

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

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
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 24 - 16

	attachment_undermount_offset_x = 26 - 16
	attachment_undermount_offset_y = 14 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/deathsquad

/obj/item/weapon/ranged/bullet/magazine/pistol/deagle/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/pistol/deagle/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.03 * L.get_skill_power(SKILL_RANGED)) )

/obj/item/weapon/ranged/bullet/magazine/pistol/deagle/mod
	name = ".50 Gold Eagle"
	desc = "Now in gold!"
	desc_extended = "A proudly American made and designed<sup>\[citation needed\]</sup> 50 calibre pistol for the most elite of commanders. This one is gold plated, and provides no tactical advantage whatsoever."
	icon = 'icons/obj/item/weapons/ranged/pistol/50_gold.dmi'
	value = 240
