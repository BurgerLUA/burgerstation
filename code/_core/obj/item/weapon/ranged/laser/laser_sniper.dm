/obj/item/weapon/ranged/energy/sniper
	name = "Multifocal Laser Sniper"
	desc = "Shine bright."
	desc_extended = "Pinnacle of Syndicate engineering, this laser sniper is outfitted with the best lens you can get in the entire sector, resulting in a laser bolt capable of catastrophic damage. Not exactly power friendly."
	icon = 'icons/obj/item/weapons/ranged/laser/sniper.dmi'
	value = 6000

	bullet_color = "#FFFFFF"

	projectile = /obj/projectile/bullet/laser/sniper
	ranged_damage_type = /damagetype/ranged/laser/rifle/sniper

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 10

	automatic = TRUE

	can_wield = TRUE
	wield_only = TRUE

	override_icon_state = TRUE
	override_icon_state_held = TRUE

	charge_cost = CELL_SIZE_BASIC / 24

	attachment_whitelist = list()

	shoot_sounds = list('sound/weapons/laser_sniper/shoot.ogg')

	heat_max = 0.1

	ai_heat_sensitivity = 2

	zoom_mul = 8

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 2
	movement_spread_base = 0.2

	size = SIZE_5
	weight = 26

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = TRUE, /obj/item/attachment/barrel/laser_charger/advanced = TRUE,
		/obj/item/attachment/barrel/suppressor = FALSE,

		/obj/item/attachment/sight/laser_sight = FALSE,
		/obj/item/attachment/sight/quickfire_adapter = FALSE,
		/obj/item/attachment/sight/red_dot = FALSE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = FALSE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

/obj/item/weapon/ranged/energy/sniper/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/sniper/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/sniper/update_icon()

	var/open_text = open_icon && open ? "_open" : ""

	icon_state = initial(icon_state)
	var/icon_state_held = "held"

	var/obj/item/powercell/PC = get_battery()

	var/charge_mod = (istype(PC) && PC.charge_current >= charge_cost) ? CEILING((PC.charge_current/PC.charge_max)*4,1) : 0

	icon_state = "[icon_state]_[charge_mod]"
	icon_state_held = "[icon_state_held]_[charge_mod]"

	if(wielded)
		icon_state_held_right = "[icon_state_held]_right_wielded"
		icon_state_held_left = "[icon_state_held]_left_wielded"
	else
		icon_state_held_right = "[icon_state_held]_right"
		icon_state_held_left = "[icon_state_held]_left"

	icon_state_held_left = "[icon_state_held_left][open_text]"
	icon_state_held_right = "[icon_state_held_right][open_text]"
	update_held_icon()

	return ..()
