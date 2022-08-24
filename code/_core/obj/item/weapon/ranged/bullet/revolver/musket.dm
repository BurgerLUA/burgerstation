/obj/item/weapon/ranged/bullet/revolver/musket
	name = "\improper .62 musket rifle"
	desc = "Just like the founding fathers intended."
	desc_extended = "A smoothbore muzzle-loading rifle that your great-great-great-great-great-great-great-great-great-grandfather used. Only an idiot or a badass would use one of these."
	icon = 'icons/obj/item/weapons/ranged/revolver/musket.dmi'
	icon_state = "inventory"
	value = 800

	company_type = "Pirate"

	tier = 1

	damage_mod = 3
	shoot_delay = 10

	can_wield = TRUE
	wield_only = TRUE

	automatic = FALSE

	bullet_count_max = 1

	shoot_sounds = list('sound/weapons/308/big_game.ogg')

	size = SIZE_2
	weight = 8

	bullet_length_min = 15.7
	bullet_length_best = 15.7
	bullet_length_max = 15.7

	bullet_diameter_min = 15.7
	bullet_diameter_best = 15.7
	bullet_diameter_max = 15.7

	heat_max = 0.1

	open = TRUE
	can_shoot_while_open = TRUE
	open_icon = FALSE

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE,

		/obj/item/attachment/stock/musket = TRUE
	)

	attachment_barrel_offset_x = 31
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 18 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 16
	attachment_undermount_offset_y = 17 - 16

	attachment_stock_offset_x = 16
	attachment_stock_offset_y = 0

	inaccuracy_modifier = 1
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.05

	pixel_x = -8



/obj/item/weapon/ranged/bullet/revolver/musket/get_static_spread()
	return 0.005 //Smoothbore

/obj/item/weapon/ranged/bullet/revolver/flintlock/get_skill_spread(var/mob/living/L)
	return max(0,0.012 - (0.012 * L.get_skill_power(SKILL_RANGED)))


/obj/item/weapon/ranged/bullet/revolver/musket/Generate()

	attachment_stock = new /obj/item/attachment/stock/musket(src)
	INITIALIZE(attachment_stock)
	GENERATE(attachment_stock)
	FINALIZE(attachment_stock)

	. = ..()