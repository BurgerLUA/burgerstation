/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper
	name = "\improper .50 BFR Sniper"
	desc = "For when you want to leave a hole the size of a basketball somewhere."
	desc_extended = "The 50 BFR is technically an Anti-Materiel Rifle, but somehow it works against Personnel just as well."
	icon = 'icons/obj/item/weapons/ranged/rifle/syndicate/50.dmi'
	icon_state = "inventory"
	value = 5000

	tier = 3

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 15

	damage_mod = 2

	automatic = FALSE

	shoot_sounds = list('sound/weapons/sniper_heavy/heavy_sniper.ogg')

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
		/obj/item/attachment/sight/scope/massive = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 48 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 27 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 41 - 16
	attachment_undermount_offset_y = 17 - 16

	attachment_stock_offset_x = 48 - 16
	attachment_stock_offset_y = 16 - 16

	dan_mode = TRUE



/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/magazine/rifle/heavy_sniper/Generate()

	. = ..()

	attachment_stock = new /obj/item/attachment/stock/sniper_50(src)
	INITIALIZE(attachment_stock)
	GENERATE(attachment_stock)
	FINALIZE(attachment_stock)

	attachment_sight = new /obj/item/attachment/sight/scope/massive(src)
	INITIALIZE(attachment_sight)
	GENERATE(attachment_sight)
	FINALIZE(attachment_sight)