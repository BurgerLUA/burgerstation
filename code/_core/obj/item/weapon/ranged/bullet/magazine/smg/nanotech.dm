/obj/item/weapon/ranged/bullet/magazine/smg/nanotech
	name = "\improper 4.6x30mm NanoTech SMG"
	desc = "For when you can't aim."
	desc_extended = "Nanotrasen's answer to the fearsome C-20r, this one has a higher firerate at the cost of a smaller round."
	icon = 'icons/obj/item/weapons/ranged/smg/nanotrasen/4mm.dmi'
	icon_state = "inventory"
	value = 2200

	company_type = "NanoTrasen"

	tier = 3

	shoot_delay = 1.15

	automatic = TRUE

	shoot_sounds = list('sound/weapons/ranged/smg/nanotech/shoot.ogg')

	can_wield = FALSE

	override_icon_state = TRUE

	size = SIZE_3
	weight = 9

	heat_max = 0.08

	bullet_length_min = 25
	bullet_length_best = 30
	bullet_length_max = 31

	bullet_diameter_min = 4
	bullet_diameter_best = 4.6
	bullet_diameter_max = 5

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
		/obj/item/attachment/sight/targeting_computer = TRUE
	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 25 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 0
	attachment_undermount_offset_y = 0

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0

	rarity = RARITY_UNCOMMON

/obj/item/weapon/ranged/bullet/magazine/smg/nanotech/update_icon()

	icon_state = initial(icon_state)

	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		var/bullet_num = FLOOR(length(M.get_ammo_count()/M.bullet_count_max)*9,1)
		icon_state = "[icon_state]_[bullet_num]"
	else
		icon_state = "[icon_state]_open"

	return ..()

/obj/item/weapon/ranged/bullet/magazine/smg/nanotech/get_static_spread()
	return 0.004

/obj/item/weapon/ranged/bullet/magazine/smg/nanotech/get_skill_spread(var/mob/living/L)
	return 0.01 - (0.02 * L.get_skill_power(SKILL_RANGED))