/obj/item/weapon/ranged/bullet/magazine/rifle/halo/covenant/needlerifle
	name = "\improper Type-31 Needle Rifle"
	desc = "Space age technology calls for space age guns. This should easily rip someone a new hole."
	desc_extended = "A unique combination of the Type-33 and Type-51."
	icon = 'icons/obj/item/weapons/ranged/rifle/halo/needlerifle.dmi'
	value = 1000

	shoot_delay = 3

	automatic = TRUE

	shoot_sounds = list(
	'sound/weapons/covenant/needle_rifle_fire1.wav',
	'sound/weapons/covenant/needle_rifle_fire2.wav',
	'sound/weapons/covenant/needle_rifle_fire3.wav')

	can_wield = TRUE

	view_punch = 20

	zoom_mul = 1
	item_slot = SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK

	size = SIZE_4
	weight = 20

	heat_per_shot = 0.04
	heat_max = 0.08

	bullet_length_min = 31
	bullet_length_best = 33
	bullet_length_max = 34

	bullet_diameter_min = 8
	bullet_diameter_best = 9
	bullet_diameter_max = 10

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

	firing_pin = /obj/item/firing_pin/electronic/iff/covenant

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/covenant/needlerifle/get_static_spread()
	if(!wielded) return 0.005
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/covenant/needlerifle/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.002 - (0.004 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/covenant/needlerifle/get_bullet_inaccuracy(var/mob/living/L,var/atom/target,var/obj/projectile/P,var/inaccuracy_modifier)

	var/distance = get_dist(L,target)

	if(distance <= 3)
		return TILE_SIZE*0.5 //No using snipers at close range.

	if(distance <= VIEW_RANGE*0.5)
		return max(0,1 - L.get_skill_power(SKILL_PRECISION)) * ((VIEW_RANGE*0.5)/get_dist(L,target)) * TILE_SIZE*0.5

	return max(0,1 - L.get_skill_power(SKILL_PRECISION))*(0.1+0.9*(get_dist(L,target) - VIEW_RANGE*0.5)) * (L.client && L.client.is_zoomed ? 0.25 : 1)