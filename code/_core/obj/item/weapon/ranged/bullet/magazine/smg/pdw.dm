/obj/item/weapon/ranged/bullet/magazine/smg/pdw
	name = "\improper 4.6x30mm WT-550"
	desc = "Something squeaks that isn't supposed to squeak? Put some WT-500 on it."
	desc_extended = "A NanoTrasen made and used personal defense weapon designed for security forces on stations. The unique 4.6x30mm ammo type offers a robust array of special rounds for all combat situations."
	icon = 'icons/obj/item/weapons/ranged/smg/nanotrasen/4mm_pdw.dmi'
	icon_state = "inventory"
	value = 1100

	company_type = "NanoTrasen"

	damage_mod = 1

	tier = 2

	automatic = TRUE
	can_wield = FALSE

	shoot_delay = 1

	firemodes = list("automatic","burst","semi-automatic")

	shoot_sounds = list('sound/weapons/ranged/smg/pdw1/shoot.ogg')

	override_icon_state = TRUE

	heat_max = 0.09

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

	size = SIZE_3
	weight = 5

	ai_heat_sensitivity = 0.5

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



		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 27 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 16 - 16

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		icon_state = "[initial(icon_state)]_[CEILING((M.get_ammo_count()/M.bullet_count_max)*5,1)]"
	else
		icon_state = "[initial(icon_state)]_open"
	..()