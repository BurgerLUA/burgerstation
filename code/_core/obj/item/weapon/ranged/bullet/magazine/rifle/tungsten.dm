/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten
	name = "\improper T20mm carbine"
	desc = "Shoots movable rods."
	desc_extended = "A special NanoTrasen Research Team tungesten shooting carbine designed to rival the syndicate energy crossbow. This version shoots tungesten rods instead of energy bolts, is more cumbersome than the energy now, and honestly really doesn't have any resemblence the energy crossbow at all."
	icon = 'icons/obj/item/weapons/ranged/smg/nanotrasen/tungsten.dmi'
	icon_state = "inventory"
	shoot_delay = 4

	company_type = "NanoTrasen"

	tier = 2

	value = 1800

	firemodes = list("semi-automatic")

	shoot_sounds = list('sound/weapons/ranged/rifle/tungsten/shoot.ogg')

	heat_max = 0.1

	bullet_length_min = 15
	bullet_length_best = 20
	bullet_length_max = 25

	bullet_diameter_min = 4
	bullet_diameter_best = 5
	bullet_diameter_max = 6

	automatic = FALSE

	override_icon_state = TRUE

	size = SIZE_3
	weight = 12

	can_wield = TRUE

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
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
		/obj/item/attachment/sight/targeting_computer = TRUE,



		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 20 - 16

	attachment_sight_offset_x = 15 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 25 - 16
	attachment_undermount_offset_y = 15 - 16

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 0.5
	movement_spread_base = 0.01

	rarity = RARITY_UNCOMMON

/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten/update_icon()

	icon_state = initial(icon_state)

	if(stored_magazine)
		icon_state = "[icon_state]_[CEILING((stored_magazine.get_ammo_count()/stored_magazine.bullet_count_max)*8, 1)]"
	else
		icon_state = "[icon_state]_open"

	. = ..()

/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/bullet/magazine/rifle/tungsten/get_cock_sound(var/direction="both")
	return 'sound/weapons/ranged/generic/smg_rack.ogg'