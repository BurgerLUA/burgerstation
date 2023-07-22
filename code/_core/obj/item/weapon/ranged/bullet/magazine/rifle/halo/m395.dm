/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m395
	name = "\improper M392 Designated Marksman Rifle"
	desc = "For when you want to be an asshole at an extended range."
	desc_extended = "This rifle favors mid- to long-ranged combat, offering impressive stopping power over a long distance. Has an inbuilt underbarrel flashlight.  Takes 7.62mm calibre magazines."
	icon = 'icons/obj/item/weapons/ranged/rifle/halo/m395.dmi'

	shoot_delay = 4

	automatic = FALSE

	shoot_sounds = list(
	'sound/weapons/unsc/dmr/marksman_rifle_1.wav',
	'sound/weapons/unsc/dmr/marksman_rifle_2.wav',
	'sound/weapons/unsc/dmr/marksman_rifle_3.wav')

	can_wield = TRUE
	wield_only = TRUE

	view_punch = 32



	size = SIZE_5
	weight = 20


	heat_per_shot = 0.07
	heat_max = 0.07

	bullet_length_min = 36
	bullet_length_best = 38
	bullet_length_max = 40

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	size = SIZE_4


	value = 200

	ai_heat_sensitivity = 2

	zoom_mul = 2

	dan_mode = TRUE

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

	attachment_sight_offset_x = 0
	attachment_sight_offset_y = 0

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 18 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/nanotrasen

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m395/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m395/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m395/get_bullet_inaccuracy(var/mob/living/L,var/atom/target,var/obj/projectile/P,var/inaccuracy_modifier)

	var/distance = get_dist(L,target)

	if(distance <= 3)
		return TILE_SIZE*0.5 //No using snipers at close range.

	if(distance <= VIEW_RANGE*0.5)
		return max(0,1 - L.get_skill_power(SKILL_PRECISION)) * ((VIEW_RANGE*0.5)/get_dist(L,target)) * TILE_SIZE*0.5

	return max(0,1 - L.get_skill_power(SKILL_PRECISION))*(0.1+0.9*(get_dist(L,target) - VIEW_RANGE*0.5)) * (L.client && L.client.is_zoomed ? 0.25 : 1)

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/m395/insurrection
	name = "\improper Modified M392 DMR"
	icon = 'icons/obj/item/weapons/ranged/rifle/halo/m395i.dmi'

	firing_pin = /obj/item/firing_pin/electronic/iff/syndicate