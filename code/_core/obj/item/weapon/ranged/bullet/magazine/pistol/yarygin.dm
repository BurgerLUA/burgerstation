/obj/item/weapon/ranged/bullet/magazine/pistol/yarygin
	name = "\improper 9x19mm VA pistol"
	desc = "Korobochka, horoni rebyat."
	desc_extended = "Slavic-produced semiautomatic 9x19 pistol, a service weapon of the Space Slavic army, special forces and other defense and law enforcement agencies."
	icon = 'icons/obj/item/weapons/ranged/pistol/yarygin.dmi'
	icon_state = "inventory"
	value = 200

	company_type = "Slavic"

	tier = 2

	shoot_delay = 3

	movement_spread_base = 0.01
	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0

	shoot_sounds = list('sound/weapons/ranged/pistol/yarg/shoot.ogg')

	can_wield = FALSE

	automatic = FALSE

	size = SIZE_1
	weight = 4

	heat_max = 0.06

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	ai_heat_sensitivity = 1.5

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
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
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 24 - 16

	attachment_undermount_offset_x = 26 - 16
	attachment_undermount_offset_y = 14 - 16

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bullet/magazine/pistol/yarygin/get_static_spread()
	return 0.004

/obj/item/weapon/ranged/bullet/magazine/pistol/yarygin/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.03 * L.get_skill_power(SKILL_RANGED)))
