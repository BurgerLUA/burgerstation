/obj/item/weapon/ranged/bullet/magazine/rifle/pulse
	name = "\improper NT-PR"
	desc = "For public relations: with Deathsquad."
	desc_extended = "A pricy and powerful magazine-fed pulse rifle that fires massive amounts of matter-destroying energy. Not for the lighthearted."
	icon = 'icons/obj/item/weapons/ranged/laser/pulse.dmi'
	icon_state = "inventory"
	value = 4000

	company_type = "NanoTrasen"

	tier_type = "heavy weapon"

	tier = 3

	shoot_delay = 4

	automatic = FALSE

	shoot_sounds = list('sound/weapons/ranged/energy/pulse/shoot.ogg')

	can_wield = TRUE

	size = SIZE_4
	weight = 20

	heat_max = 0.1

	bullet_length_min = 52
	bullet_length_best = 52
	bullet_length_max = 52

	bullet_diameter_min = 13
	bullet_diameter_best = 13
	bullet_diameter_max = 13

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



		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE,
		/obj/item/attachment/undermount/gun/grenade_launcher = TRUE
	)

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 17 - 16

	dan_mode = TRUE

	override_icon_state = TRUE

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.03

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bullet/magazine/rifle/pulse/get_static_spread()
	return 0.002

/obj/item/weapon/ranged/bullet/magazine/rifle/pulse/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/pulse/update_icon()

	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		var/icon_num = CEILING(3*(M.get_ammo_count()/M.bullet_count_max),1)
		icon_state = "[initial(icon_state)]_[icon_num]"
	else
		icon_state = "[initial(icon_state)]_open"

	return ..()
