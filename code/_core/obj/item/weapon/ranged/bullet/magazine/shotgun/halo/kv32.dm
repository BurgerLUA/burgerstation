/obj/item/weapon/ranged/bullet/magazine/shotgun/halo/kv32
	name = "\improper KV-32 automatic shotgun"
	desc = "A spooky gun produced on backwater colonies."
	desc_extended = "A very deadful weapon in arms of good soldier. Despite the small magazine and shitty accuracy - this shotgun have a very big firerate, which allows you to shoot 4 times in once."
	icon = 'icons/obj/item/weapons/ranged/shotgun/kv32.dmi'
	value = 1000

	shoot_delay = 0.5

	automatic = TRUE

	shoot_sounds = list('sound/weapons/ranged/shotgun/bulldog/shoot.ogg')

	can_wield = TRUE



	size = SIZE_3
	weight = 11

	heat_max = 0.4

	bullet_length_min = 18
	bullet_length_best = 18.5
	bullet_length_max = 19

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19

	ai_heat_sensitivity = 0.75

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/laser_charger/advanced = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,

		/obj/item/attachment/sight/laser_sight = FALSE,
		/obj/item/attachment/sight/quickfire_adapter = FALSE,
		/obj/item/attachment/sight/red_dot = FALSE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = FALSE,



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 14 - 14
	attachment_sight_offset_y = 21 - 14

	attachment_undermount_offset_x = 23 - 12
	attachment_undermount_offset_y = 12 - 13

	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

/obj/item/weapon/ranged/bullet/magazine/shotgun/halo/kv32/get_base_spread()
	return 0.3

/obj/item/weapon/ranged/bullet/magazine/shotgun/halo/kv32/get_static_spread()
	return 0.008

/obj/item/weapon/ranged/bullet/magazine/shotgun/halo/kv32/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.09 - (0.16 * L.get_skill_power(SKILL_RANGED)))