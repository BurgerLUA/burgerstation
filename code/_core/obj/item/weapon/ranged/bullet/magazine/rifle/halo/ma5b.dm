/obj/item/weapon/ranged/bullet/magazine/rifle/halo/ma5b
	name = "\improper MA5B Assault Rifle"
	desc = "Space age technology calls for space age guns. This should easily rip someone a new hole."
	desc_extended = "Standard-issue service rifle of the UNSC Marines. Has an inbuilt underbarrel flashlight. Takes 7.62mm calibre magazines."
	icon = 'icons/obj/item/weapons/ranged/rifle/halo/ma5b.dmi'
	value = 150

	shoot_delay = 1.5

	automatic = TRUE

	icon_state_worn = "worn"
	item_slot = SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK
	slot_icons = TRUE

	shoot_sounds = list(
	'sound/weapons/unsc/assault_rifle/19103_b.wav',
	'sound/weapons/unsc/assault_rifle/19203_b.wav',
	'sound/weapons/unsc/assault_rifle/19204_b.wav')

	can_wield = TRUE

	view_punch = 10

	size = SIZE_4
	weight = 20

	heat_per_shot = 0.04
	heat_max = 0.08

	bullet_length_min = 36
	bullet_length_best = 38
	bullet_length_max = 40

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

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

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 22 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 24 - 16
	attachment_undermount_offset_y = 14 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/nanotrasen

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/ma5b/get_static_spread()
	if(!wielded) return 0.2
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/ma5b/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.02 - (0.06 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/ma5b/insurrection

	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/ma5b/commando
	name = "\improper MA5D Assault Rifle"
	shoot_delay = 0.8
	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate