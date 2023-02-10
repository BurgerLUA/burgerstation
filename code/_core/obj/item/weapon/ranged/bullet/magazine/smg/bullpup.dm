/obj/item/weapon/ranged/bullet/magazine/smg/bullpup
	name = ".45 C-20r"
	desc = "GET DAT FUKKEN DISK"
	desc_extended = "Commonly used by Syndicate Operatives for its reliability and light weight, the 45 C-20r was the primary firearm of the Syndicate Nuclear Operatives, before NT figured out having self destruct nukes on their station wasn't a great idea."
	icon = 'icons/obj/item/weapons/ranged/smg/syndicate/45.dmi'
	icon_state = "inventory"
	value = 1200

	tier = 2

	shoot_delay = 1.5

	company_type = "Syndicate"

	automatic = TRUE

	shoot_sounds = list('sound/weapons/45/shoot.ogg')

	firemodes = list("automatic","burst","semi-automatic")

	dan_mode = TRUE
	can_wield = TRUE

	size = SIZE_3
	weight = 10

	heat_max = 0.09

	bullet_length_min = 20
	bullet_length_best = 23
	bullet_length_max = 24

	bullet_diameter_min = 11
	bullet_diameter_best = 11.43
	bullet_diameter_max = 12

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
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 22 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 16 - 16

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))



/obj/item/weapon/ranged/bullet/magazine/smg/bullpup/mod

	name = ".45 C-20r MOD"

	icon = 'icons/obj/item/weapons/ranged/smg/syndicate/45_mod.dmi'

	tier = 3

	shoot_delay = 1

	weight = 8

	heat_max = 0.07

	attachment_barrel_offset_x = 28 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 21 - 16
	attachment_sight_offset_y = 20 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 16 - 16

	rarity = RARITY_RARE