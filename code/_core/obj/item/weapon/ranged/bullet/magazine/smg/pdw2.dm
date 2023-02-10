/obj/item/weapon/ranged/bullet/magazine/smg/pdw2
	name = "\improper 4.6x30mm HL7"
	desc = "Something squeaks that isn't supposed to squeak? Put some HL7 on it."
	desc_extended = "An early prototype of the WT-550 featuring better quality parts. The design was eventually scrapped by NanoTrasen after they realised there was no space to put a grenade launcher on it."
	icon = 'icons/obj/item/weapons/ranged/smg/nanotrasen/4mm_pdw_2.dmi'
	icon_state = "inventory"
	value = 1100

	company_type = "NanoTrasen"

	damage_mod = 1

	tier = 3

	automatic = TRUE
	can_wield = FALSE

	shoot_delay = 0.75

	firemodes = list("automatic")

	shoot_sounds = list('sound/weapons/smg_light/smg.ogg')

	heat_max = 0.09

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

	size = SIZE_3
	weight = 7

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
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 11 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 16 - 16
	attachment_undermount_offset_y = 16 - 16

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0

	rarity = RARITY_RARE

/obj/item/weapon/ranged/bullet/magazine/smg/pdw2/get_static_spread()
	return 0.004

/obj/item/weapon/ranged/bullet/magazine/smg/pdw2/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)))