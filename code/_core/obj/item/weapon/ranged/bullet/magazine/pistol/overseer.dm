/obj/item/weapon/ranged/bullet/magazine/pistol/overseer
	name = "\improper 12.7mm High-Power Auto"
	desc = "The \"Auto\" is for semiauto."
	desc_extended = "A very powerful semiautomatic pistol designed for high ranking NanoTrasen commanders. The bulkiness of the pistol rivals submachine guns."
	icon = 'icons/obj/item/weapons/ranged/pistol/12mm_nt.dmi'
	icon_state = "inventory"
	value = 150

	shoot_delay = 3

	automatic = FALSE

	shoot_sounds = list('sound/weapons/12/shoot.ogg')

	can_wield = FALSE

	view_punch = 20

	slowdown_mul_held = HELD_SLOWDOWN_SMG

	size = SIZE_2


	heat_per_shot = 0.06
	heat_max = 0.10

	bullet_length_min = 27
	bullet_length_best = 33
	bullet_length_max = 34

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 18- 16

	attachment_sight_offset_x = 20 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 30
	attachment_undermount_offset_y = 16

/obj/item/weapon/ranged/bullet/magazine/pistol/overseer/get_static_spread() //Base spread
	return 0

/obj/item/weapon/ranged/bullet/magazine/pistol/overseer/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.04 - (0.04 * L.get_skill_power(SKILL_RANGED)))