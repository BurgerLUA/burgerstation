/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127
	name = "\improper 12.7x90mm Bolt-Action Sniper Rifle"
	desc = "Pick up a real gun."
	desc_extended = "An absolute unit of a sniper rifle. The bullet is so large, it absolutely needs to be bolt action."
	icon = 'icons/obj/item/weapons/ranged/rifle/nanotrasen/127_1.dmi'
	icon_state = "inventory"

	shoot_delay = 10

	automatic = FALSE

	shoot_sounds = list('sound/weapons/rifle_heavy/shoot.ogg')

	can_wield = TRUE
	wield_only = TRUE

	view_punch = 32

	size = SIZE_5
	weight = 25

	heat_per_shot = 0.07
	heat_max = 0.07

	bullet_length_min = 80
	bullet_length_best = 90
	bullet_length_max = 100

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	value = 1200

	ai_heat_sensitivity = 2
	dan_mode = TRUE

	attachment_whitelist = list(
		/obj/item/attachment/stock/sniper_127 = TRUE, //Actually the barrel but I want barrel attachments for the gun.

		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/suppressor = TRUE,


		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 48 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 17 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 31 - 16
	attachment_undermount_offset_y = 17 - 16

	attachment_stock_offset_x = 32 - 16
	attachment_stock_offset_y = 19 - 16

	requires_cock_each_shot = TRUE

	zoom_mul = 1

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.005 - (0.005 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127/get_bullet_inaccuracy(var/mob/living/L,var/atom/target,var/obj/projectile/P,var/inaccuracy_modifier)

	var/distance = get_dist(L,target)

	if(distance <= 3)
		return TILE_SIZE*0.5 //No using snipers at close range.

	if(distance <= VIEW_RANGE*0.5)
		return max(0,1 - L.get_skill_power(SKILL_PRECISION)) * ((VIEW_RANGE*0.5)/get_dist(L,target)) * TILE_SIZE*0.5

	return max(0,1 - L.get_skill_power(SKILL_PRECISION))*(0.1+0.9*(get_dist(L,target) - VIEW_RANGE*0.5)) * (L.client && L.client.is_zoomed ? 0.25 : 1)


/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127/equipped/Generate()

	attachment_stock = new /obj/item/attachment/stock/sniper_127(src)
	INITIALIZE(attachment_stock)
	GENERATE(attachment_stock)
	FINALIZE(attachment_stock)

	attachment_sight = new /obj/item/attachment/sight/scope/large(src)
	INITIALIZE(attachment_sight)
	GENERATE(attachment_sight)
	FINALIZE(attachment_sight)

	return ..()