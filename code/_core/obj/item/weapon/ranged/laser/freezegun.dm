/obj/item/weapon/ranged/energy/freezegun
	name = "freeze ray"
	desc = "Get iced, dummy."
	desc_extended = "A gun that shoots beams that freeze the opponent."
	icon = 'icons/obj/item/weapons/ranged/laser/freezegun.dmi'
	value = 4000

	projectile = /obj/projectile/bullet/laser/strong
	ranged_damage_type = /damagetype/ranged/laser/freezegun

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 4

	automatic = TRUE

	bullet_color = "#00FFFF"

	charge_cost = CELL_SIZE_BASIC / 30

	shoot_sounds = list('sound/weapons/chronogun/fire.ogg')

	override_icon_state = TRUE

	heat_max = 0.04

	size = SIZE_4
	weight = 15

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = TRUE, /obj/item/attachment/barrel/laser_charger/advanced = TRUE,
		/obj/item/attachment/barrel/suppressor = FALSE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

		/obj/item/attachment/stock/c20r = FALSE,

		/obj/item/attachment/undermount/angled_grip = TRUE,
		/obj/item/attachment/undermount/bipod = TRUE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 15 - 16

	attachment_sight_offset_x = 17 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 27 - 16
	attachment_undermount_offset_y = 12 - 14

	inaccuracy_modifier = 0.25
	movement_inaccuracy_modifier = 1
	movement_spread_base = 0.05

/obj/item/weapon/ranged/energy/freezegun/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/energy/freezegun/get_skill_spread(var/mob/living/L)
	return max(0,0.01 - (0.02 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/freezegun/update_icon()

	var/obj/item/powercell/PC = get_battery()

	if(!istype(PC) || charge_cost > PC.charge_current)
		icon_state = "inventory_0"
	else
		icon_state = "inventory_[FLOOR((PC.charge_current/PC.charge_max) * 4, 1)]"

	return ..()
