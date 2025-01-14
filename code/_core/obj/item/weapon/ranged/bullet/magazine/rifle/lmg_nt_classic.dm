/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt_classic
	name = "\improper 5.56mm NT49"
	desc = "A lighter light machine gun."
	desc_extended = ""
	icon = 'icons/obj/item/weapons/ranged/rifle/nanotrasen/556_8.dmi'
	icon_state = "inventory"
	value = 3000

	company_type = "NanoTrasen"

	tier_type = "heavy weapon"

	tier = 3

	shoot_delay = 1

	automatic = TRUE

	damage_mod = 1.15

	shoot_sounds = list('sound/weapons/ranged/rifle/lmg_classic/shoot.ogg')

	can_wield = TRUE
	wield_only = TRUE

	size = SIZE_4
	weight = 14

	heat_max = 0.08

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	ai_heat_sensitivity = 0.5

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
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 14 - 16
	attachment_sight_offset_y = 19 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 17 - 16

	dan_mode = TRUE

	inaccuracy_modifier = 1
	movement_inaccuracy_modifier = 0.5
	movement_spread_base = 0.1

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt_classic/get_static_spread()
	return 0.003

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg_nt_classic/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))