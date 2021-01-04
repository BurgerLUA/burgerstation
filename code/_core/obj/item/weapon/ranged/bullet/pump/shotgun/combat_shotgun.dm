/obj/item/weapon/ranged/bullet/pump/shotgun/combat
	name = "12g Combat Shotgun"
	desc = "Reliable, cheap, and strong."
	desc_extended = "A very robust pump action shotgun for Private Military Corporations."
	icon = 'icons/obj/item/weapons/ranged/shotgun/combat.dmi'
	icon_state = "inventory"
	value = 70

	shoot_delay = 4

	automatic = FALSE

	bullet_count_max = 8

	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	can_wield = TRUE

	icon_state_worn = "worn"
	item_slot = SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK
	slot_icons = TRUE

	view_punch = 12



	size = SIZE_4
	weight = 12


	value = 130

	heat_per_shot = 0.02
	heat_max = 0.08

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
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 14 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/deathsquad

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/get_static_spread()
	return 0.002

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.005 - (0.005 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/get_base_spread()
	return 0.1

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod
	name = "12 gauge modified combat shotgun"
	desc = "A very robust combat shotgun. This one has been modified to be have a pistol grip and be shorter."
	icon = 'icons/obj/item/weapons/ranged/shotgun/combat_mod.dmi'
	icon_state = "inventory"

	shoot_delay = 2

	automatic = FALSE

	bullet_count_max = 6


	shoot_sounds = list('sound/weapons/combat_shotgun/shoot.ogg')

	can_wield = TRUE

	view_punch = 16



	size = SIZE_3


	value = 150

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod/get_static_spread()
	return 0.004

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/combat/mod/get_base_spread()
	return 0.15