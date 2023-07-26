/obj/item/weapon/ranged/bullet/revolver/halo/handcannon
	name = "\improper Custom Handcannon"
	desc = "Can't spell overkill without 14.5"
	desc_extended = "A very rare sidearm made for some kind of big game hunting. Takes 14.5mm shells."
	icon = 'icons/obj/item/weapons/ranged/revolver/halo/handcannon.dmi'
	icon_state = "inventory"
	value = 1200

	company_type = "United Rebel Front"

	tier = 3

	damage_mod = 1.3
	shoot_delay = 6.2

	automatic = FALSE

	bullet_count_max = 1

	shoot_sounds = list('sound/weapons/halo/unsc/big_game.ogg')

	size = SIZE_3
	weight = 12
	dan_mode = FALSE
	bullet_length_min = 66
	bullet_length_best = 67
	bullet_length_max = 67

	bullet_diameter_min = 7.6
	bullet_diameter_best = 7.62
	bullet_diameter_max = 7.7

	heat_max = 0.1

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/charger/advanced = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = FALSE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = FALSE,
		/obj/item/attachment/stock_mod/reinforced_stock = FALSE,

		/obj/item/attachment/sight/laser_sight = FALSE,
		/obj/item/attachment/sight/quickfire_adapter = FALSE,
		/obj/item/attachment/sight/red_dot = FALSE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = FALSE,



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 24 - 16

	attachment_sight_offset_x = 12 - 16
	attachment_sight_offset_y = 25 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 17 - 16

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.2

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bullet/revolver/halo/handcannon/get_static_spread()
	return 0

/obj/item/weapon/ranged/bullet/revolver/halo/handcannon/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.02 * L.get_skill_power(SKILL_RANGED)))