/obj/item/weapon/ranged/bullet/magazine/rifle/m4_soap

	name = "\improper 5.56mm M5 SOAPMOD"
	desc = "Made in the Space Colonies!"
	desc_extended = "A tactically modified version of the M5A2 assault rifle, with built-in attachments for squeaky-clean operations."
	icon = 'icons/obj/item/weapons/ranged/rifle/sol/merc_nt.dmi'
	icon_state = "inventory"
	value = 1800

	company_type = "NanoTrasen"

	tier = 3

	damage_mod = 1.15
	shoot_delay = 1.15

	automatic = FALSE

	firemodes = list("automatic","semi-automatic")

	shoot_sounds = list('sound/weapons/ranged/rifle/m4/shoot.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 20

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ai_heat_sensitivity = 0.75

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE,
		/obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = TRUE,
		/obj/item/attachment/stock_mod/reinforced_stock = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,
		/obj/item/attachment/sight/m4 = TRUE,



		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE,
		/obj/item/attachment/undermount/gun/grenade_launcher = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 14 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 23 - 16
	attachment_undermount_offset_y = 16 - 16

	dan_mode = TRUE

	heat_max = 0.1

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.02

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bullet/magazine/rifle/m4_soap/Generate()

	. = ..()

	attachment_barrel = new /obj/item/attachment/barrel/suppressor(src)
	INITIALIZE(attachment_barrel)
	GENERATE(attachment_barrel)
	FINALIZE(attachment_barrel)

	attachment_sight = new /obj/item/attachment/sight/red_dot(src)
	INITIALIZE(attachment_sight)
	GENERATE(attachment_sight)
	FINALIZE(attachment_sight)

	attachment_undermount = new /obj/item/attachment/undermount/gun/grenade_launcher(src)
	INITIALIZE(attachment_undermount)
	GENERATE(attachment_undermount)
	FINALIZE(attachment_undermount)