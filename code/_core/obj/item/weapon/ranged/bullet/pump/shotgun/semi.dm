/obj/item/weapon/ranged/bullet/pump/shotgun/semi
	name = "12g SEM"
	desc = "When you're too lazy to pump."
	desc_extended = "A lightweight 12 gauge auto-cycling semi-automatic shotgun designed to clear rooms very fast without the effort of pumping; except when you load a new round in for the first time."
	icon = 'icons/obj/item/weapons/ranged/shotgun/nanotrasen/semi.dmi'
	icon_state = "inventory"

	company_type = "NanoTrasen"

	value = 3000

	tier = 3

	damage_mod = 1
	shoot_delay = 4

	automatic = FALSE

	can_wield = TRUE

	bullet_count_max = 6

	shoot_sounds = list('sound/weapons/ranged/shotgun/semi/shoot.ogg')

	size = SIZE_3
	weight = 12

	bullet_length_min = 76
	bullet_length_best = 76.2
	bullet_length_max = 76.4

	bullet_diameter_min = 18
	bullet_diameter_best = 18.5
	bullet_diameter_max = 19

	heat_max = 0.16

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

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 0 - 16
	attachment_undermount_offset_y = 0 - 16

	dan_mode = TRUE

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0.5

	pump_delay = 1

	rarity = RARITY_UNCOMMON

/obj/item/weapon/ranged/bullet/pump/shotgun/semi

/obj/item/weapon/ranged/bullet/pump/shotgun/semi/get_static_spread()
	return 0.007

/obj/item/weapon/ranged/bullet/pump/shotgun/semi/get_skill_spread(mob/living/L)
	return max(0,0.04 - (0.08 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/pump/shotgun/semi/get_base_spread()
	return 0.2

/obj/item/weapon/ranged/bullet/pump/shotgun/semi/handle_ammo(mob/caller)
	. = ..()
	pump(silent = TRUE)

