/obj/item/weapon/ranged/bullet/pump/shotgun/halo/m45
	name = "M45 Combat Shotgun"
	desc = "Reliable, cheap, and strong."
	desc_extended = "The UNSC's older model primary shotgun. An effective close range infantry weapon used by colonial police and insurrectionists abroad."
	icon = 'icons/obj/item/weapons/ranged/shotgun/m45.dmi'

	shoot_delay = 4

	automatic = FALSE

	bullet_count_max = 12

	shoot_sounds = list(
	'sound/weapons/halo/unsc/shotgun/shotgun1.wav',
	'sound/weapons/halo/unsc/shotgun/shotgun2.wav',
	'sound/weapons/halo/unsc/shotgun/shotgun3.wav')

	can_wield = TRUE

	icon_state_worn = "worn"

	worn_layer = LAYER_MOB_CLOTHING_BACK
	slot_icons = TRUE





	size = SIZE_4
	weight = 12


	value = 200


	heat_max = 0.08

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
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 14 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

/obj/item/weapon/ranged/bullet/pump/shotgun/halo/m45/get_static_spread()
	return 0.002

/obj/item/weapon/ranged/bullet/pump/shotgun/halo/m45/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.005 - (0.005 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/halo/m45/get_base_spread()
	return 0.1