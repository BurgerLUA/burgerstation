/obj/item/weapon/ranged/bullet/magazine/rifle/lmg
	name = "\improper .223 Defender LMG"
	desc = "Atatatatatatata."
	desc_extended = "The .223 Defender Light Machine Gun is a not very light machine gun meant to fire a lot of rounds in quick succession for relatively extended periods of time. Was designed by syndicate weapon scientists to take 5.56mm rounds that are commonly dropped by the enemy."
	icon = 'icons/obj/item/weapons/ranged/rifle/syndicate/223_lmg.dmi'
	icon_state = "inventory"
	value = 4500

	company_type = "Syndicate"

	tier_type = "heavy weapon"

	tier = 3

	shoot_delay = 1.6

	automatic = TRUE

	damage_mod = 1.3

	shoot_sounds = list('sound/weapons/ranged/rifle/lmg_syndicate/shoot.ogg')

	can_wield = TRUE

	override_icon_state = TRUE

	override_icon_state_held = TRUE

	heat_max = 0.2

	bullet_length_min = 40
	bullet_length_best = 45
	bullet_length_max = 46

	bullet_diameter_min = 5.5
	bullet_diameter_best = 5.56
	bullet_diameter_max = 5.6

	size = SIZE_4
	weight = 30

	ai_heat_sensitivity = 0.25

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

	attachment_barrel_offset_x = 32 - 16
	attachment_barrel_offset_y = 18 - 16

	attachment_sight_offset_x = 11 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 22 - 16
	attachment_undermount_offset_y = 13 - 16



	inaccuracy_modifier = 1
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.1

	rarity = RARITY_RARE


/obj/item/weapon/ranged/bullet/magazine/rifle/lmg/update_icon()

	var/modifier = "[wielded ? "_wielded" : ""][open ? "_open" : ""][stored_magazine ? "_1" : ""]"

	icon_state_held_right = "held_right[modifier]"
	icon_state_held_left = "held_left[modifier]"

	if(stored_magazine)
		var/obj/item/magazine/M = stored_magazine
		var/math_mod = (M.get_ammo_count()/M.bullet_count_max)*5
		icon_state = "[initial(icon_state)][open ? "_open" : ""]_[CEILING(math_mod, 1)]"
	else
		icon_state = "[initial(icon_state)][open ? "_open" : ""]"

	update_held_icon()

	return ..()

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/bullet/magazine/rifle/lmg/get_skill_spread(var/mob/living/L)
	return max(0,0.075 - (0.1 * L.get_skill_power(SKILL_RANGED)))