/obj/item/weapon/ranged/bullet/magazine/smg/pdw
	name = "\improper 4.6x30mm WT-550"
	desc = "Something squeaks that isn't supposed to squeak? Put some WT-500 on it."
	desc_extended = "A NanoTrasen made and used personal defense weapon designed for security forces on stations. The unique 4.6x30mm ammo type offers a robust array of special rounds for all combat situations."
	icon = 'icons/obj/item/weapons/ranged/smg/4mm.dmi'
	icon_state = "inventory"

	automatic = TRUE
	can_wield = FALSE

	shoot_delay = 1.2
	view_punch = 4

	shoot_sounds = list('sound/weapons/smg_light/smg.ogg')

	override_icon_state = TRUE

	heat_per_shot = 0.02
	heat_max = 0.09

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

	size = SIZE_3
	weight = 6

	value = 110

	ai_heat_sensitivity = 0.5

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = TRUE, /obj/item/attachment/barrel/charger/advanced = TRUE,
		/obj/item/attachment/barrel/compensator = TRUE,
		/obj/item/attachment/barrel/extended = TRUE,
		/obj/item/attachment/barrel/gyro = TRUE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/suppressor = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 13 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 16 - 16

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/smg/pdw/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		icon_state = "[initial(icon_state)]_[CEILING((length(M.stored_bullets)/M.bullet_count_max)*5,1)]"
	else
		icon_state = "[initial(icon_state)]_open"
	..()