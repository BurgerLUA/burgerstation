/obj/item/weapon/ranged/bullet/magazine/pistol/high_power
	name = "10mm NT Penumbra Pistol"
	desc = "For when 9mm isn't big enough."
	desc_extended = "The 10mm NanoTrasen Pistol is a more advanced pistol for a more advanced user. While the recoil and weight is a little hard to manage, an expert with this gun can do some serious damage."
	icon = 'icons/obj/item/weapons/ranged/pistol/10mm_nt.dmi'
	icon_state = "inventory"
	value = 200

	shoot_delay = 1.6

	automatic = FALSE

	shoot_sounds = list('sound/weapons/10/shoot.ogg')

	can_wield = FALSE

	view_punch = 10

	slowdown_mul_held = HELD_SLOWDOWN_PISTOL

	size = SIZE_2

	heat_per_shot = 0.02
	heat_max = 0.12

	bullet_length_min = 25
	bullet_length_best = 32
	bullet_length_max = 33

	bullet_diameter_min = 10
	bullet_diameter_best = 10.17
	bullet_diameter_max = 11

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

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 28 - 16
	attachment_barrel_offset_y = 22 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 23 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 17 - 16

/obj/item/weapon/ranged/bullet/magazine/pistol/high_power/get_static_spread() //Base spread
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/pistol/high_power/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.015 - (0.03 * L.get_skill_power(SKILL_RANGED)))