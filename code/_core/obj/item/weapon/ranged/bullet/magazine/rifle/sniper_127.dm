/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127
	name = "\improper 12.7x90mm Bolt-Action Sniper Rifle"
	desc = "Pick up a real gun."
	desc_extended = "An absolute unit of a sniper rifle. The bullet is so large, it absolutely needs to be bolt action."
	icon = 'icons/obj/item/weapons/ranged/rifle/nanotrasen/127_1.dmi'
	icon_state = "inventory"
	value = 5000

	tier = 3

	shoot_delay = 15

	automatic = FALSE

	damage_mod = 2

	shoot_sounds = list('sound/weapons/rifle_heavy/shoot.ogg')

	can_wield = TRUE
	wield_only = TRUE

	size = SIZE_5
	weight = 25

	heat_max = 0.08

	bullet_length_min = 80
	bullet_length_best = 90
	bullet_length_max = 100

	bullet_diameter_min = 12
	bullet_diameter_best = 12.7
	bullet_diameter_max = 13

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

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 2

	movement_spread_base = 0.2

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.005 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/sniper_127/Generate()

	attachment_stock = new /obj/item/attachment/stock/sniper_127(src)
	INITIALIZE(attachment_stock)
	GENERATE(attachment_stock)
	FINALIZE(attachment_stock)

	attachment_sight = new /obj/item/attachment/sight/scope/large(src)
	INITIALIZE(attachment_sight)
	GENERATE(attachment_sight)
	FINALIZE(attachment_sight)

	. = ..()