/obj/item/weapon/ranged/bullet/magazine/smg/syn_smg
	name = ".40 SYN-SMG"
	desc = "This looks ugly."
	desc_extended = "An early prototype of the 9x22mm NanoTech SMG. This one uses .40 ammo."
	icon = 'icons/obj/item/weapons/ranged/smg/40_advanced.dmi'
	icon_state = "inventory"
	value = 1500

	tier = 2

	shoot_delay = 1.1

	automatic = TRUE

	shoot_sounds = list('sound/weapons/40/shoot_smg.ogg')

	can_wield = FALSE

	override_icon_state = TRUE

	size = SIZE_3
	weight = 10

	heat_max = 0.06

	bullet_length_min = 21
	bullet_length_best = 22
	bullet_length_max = 23

	bullet_diameter_min = 9.8
	bullet_diameter_best = 10
	bullet_diameter_max = 11.2

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

		/obj/item/attachment/stock/c20r = FALSE
	)

	attachment_barrel_offset_x = 29 - 16
	attachment_barrel_offset_y = 19 - 16

	attachment_sight_offset_x = 25 - 16
	attachment_sight_offset_y = 21 - 16

	attachment_undermount_offset_x = 0
	attachment_undermount_offset_y = 0

	inaccuracy_modifier = 0.75
	movement_inaccuracy_modifier = 0



/obj/item/weapon/ranged/bullet/magazine/smg/syn_smg/update_icon()
	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		var/bullet_num = FLOOR((length(M.stored_bullets)/M.bullet_count_max)*17,1)
		icon_state = "[initial(icon_state)]_[bullet_num]"
	else
		icon_state = initial(icon_state)

	..()

/obj/item/weapon/ranged/bullet/magazine/smg/syn_smg/get_static_spread()
	return 0.025

/obj/item/weapon/ranged/bullet/magazine/smg/syn_smg/get_skill_spread(var/mob/living/L)
	return 0.02 - (0.04 * L.get_skill_power(SKILL_RANGED))