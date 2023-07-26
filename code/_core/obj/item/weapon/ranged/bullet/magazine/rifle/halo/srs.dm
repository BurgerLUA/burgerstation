/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs
	name = "\improper SRS99 sniper rifle"
	desc = "For when you want to leave a hole the size of a basketball somewhere."
	desc_extended = "Special Applications Rifle, system 99 Anti-Matériel. Deadly at extreme range.  Takes 14.5mm calibre magazines."
	icon = 'icons/obj/item/weapons/ranged/rifle/halo/srs.dmi'
	icon_state = "inventory"
	value = 5000

	company_type = "UNSC"

	tier_type = "sniper rifle"

	tier = 3

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 14

	damage_mod = 2

	automatic = FALSE

	shoot_sounds = list(
	'sound/weapons/halo/unsc/srs/sniper_fire_h3_1.wav',
	'sound/weapons/halo/unsc/srs/sniper_fire_h3_2.wav',
	'sound/weapons/halo/unsc/srs/sniper_fire_h3_3.wav',
	'sound/weapons/halo/unsc/srs/sniper_fire_h3_4.wav')


	can_wield = TRUE
	wield_only = TRUE

	heat_max = 0.05

	bullet_length_min = 90
	bullet_length_best = 99
	bullet_length_max = 100

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

	size = SIZE_5
	weight = 30

	ai_heat_sensitivity = 2

	zoom_mul = 2

	attachment_whitelist = list()

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 2
	movement_spread_base = 0.2

	pixel_x = -12

	attachment_whitelist = list(
		/obj/item/attachment/stock/sniper_50 = TRUE, //Actually the barrel but I want barrel attachments for the gun.

		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/charger/advanced = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = FALSE,
		/obj/item/attachment/stock_mod/reinforced_stock = TRUE,


		/obj/item/attachment/sight/laser_sight = FALSE,
		/obj/item/attachment/sight/quickfire_adapter = FALSE,
		/obj/item/attachment/sight/red_dot = FALSE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/scope/massive = TRUE,
		/obj/item/attachment/sight/targeting_computer = FALSE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 48 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 27 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 41 - 16
	attachment_undermount_offset_y = 17 - 16

	attachment_stock_offset_x = 48 - 16
	attachment_stock_offset_y = 16 - 16

	dan_mode = FALSE

	rarity = RARITY_RARE



/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/magazine/rifle/halo/srs/Generate()

	. = ..()

	attachment_stock = new /obj/item/attachment/stock/sniper_50(src)
	INITIALIZE(attachment_stock)
	GENERATE(attachment_stock)
	FINALIZE(attachment_stock)

	attachment_sight = new /obj/item/attachment/sight/scope/massive(src)
	INITIALIZE(attachment_sight)
	GENERATE(attachment_sight)
	FINALIZE(attachment_sight)