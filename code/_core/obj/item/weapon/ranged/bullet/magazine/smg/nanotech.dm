/obj/item/weapon/ranged/bullet/magazine/smg/nanotech
	name = "9x19mm NanoTech SMG"
	desc = "For when you can't aim."
	desc_extended = "Nanotrasen's answer to the fearsome C-20r, this one has a higher firerate at the cost of a smaller round."
	icon = 'icons/obj/item/weapons/ranged/smg/9mm_2.dmi'
	icon_state = "inventory"

	shoot_delay = 1.5

	automatic = TRUE

	shoot_sounds = list('sound/weapons/40/shoot_smg.ogg')

	can_wield = FALSE

	override_icon_state = TRUE

	view_punch = 6



	size = SIZE_3
	weight = 7

	heat_per_shot = 0.02
	heat_max = 0.05

	bullet_length_min = 16
	bullet_length_best = 19
	bullet_length_max = 20

	bullet_diameter_min = 8.5
	bullet_diameter_best = 9
	bullet_diameter_max = 9.5

	value = 200

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

		/obj/item/attachment/stock/c20r = FALSE
	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 25 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 0
	attachment_undermount_offset_y = 0

/obj/item/weapon/ranged/bullet/magazine/smg/nanotech/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		var/bullet_num = FLOOR((length(M.stored_bullets)/M.bullet_count_max)*9,1)
		icon_state = "[initial(icon_state)]_[bullet_num]"
	else
		icon_state = initial(icon_state)

	return ..()

/obj/item/weapon/ranged/bullet/magazine/smg/nanotech/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/bullet/magazine/smg/nanotech/get_skill_spread(var/mob/living/L)
	if(!heat_current) return 0
	return 0.02 - (0.04 * L.get_skill_power(SKILL_RANGED))