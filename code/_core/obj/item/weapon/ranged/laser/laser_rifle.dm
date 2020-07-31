/obj/item/weapon/ranged/energy/rifle
	name = "AER13 Laser Rifle"
	desc = "Pew pew pew!"
	desc_extended = "A modular model of laser rifle, capable of using different crystals to shoot beams with different effects. This one is the standard beam."
	icon = 'icons/obj/item/weapons/ranged/laser/modular.dmi'

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/rifle

	bullet_color = "#FF0000"

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 4

	automatic = FALSE

	override_icon_state = TRUE
	override_icon_state_held = FALSE //TODO: FIX THIS

	charge_max = CELL_SIZE_ADVANCED
	charge_current = CELL_SIZE_ADVANCED
	charge_cost = CELL_SIZE_ADVANCED / 40

	view_punch = 16

	shoot_sounds = list('sound/weapons/laser_rifle/shoot.ogg')

	heat_per_shot = 0.06
	heat_max = 0.1

	polymorphs = list(
		"base" = "#FFFFFF",
		"barrel" = "#FF0000"
	)

	size = SIZE_4

	value = 900

	attachment_whitelist = list(
		/obj/item/attachment/barrel/laser_charger = TRUE,
		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/undermount/burst_adapter = TRUE,
		/obj/item/attachment/undermount/vertical_grip = TRUE
	)

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 15 - 16

	attachment_sight_offset_x = 17 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 29 - 16
	attachment_undermount_offset_y = 12 - 16

/obj/item/weapon/ranged/energy/rifle/get_static_spread() //Base spread
	return 0.001

/obj/item/weapon/ranged/energy/rifle/get_skill_spread(var/mob/living/L) //Base spread
	return max(0,0.01 - (0.04 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/rifle/New(var/desired_loc)
	. = ..()
	update_sprite()
	return .

/obj/item/weapon/ranged/energy/rifle/update_overlays()

	var/true_charge = FLOOR(charge_current/charge_cost, 1) / FLOOR(charge_max/charge_cost, 1)

	var/image/I = new/image(initial(icon),"ammo_[CEILING(true_charge * 8, 1)]")
	I.color = polymorphs["barrel"]
	add_overlay(I)
	return ..()

/obj/item/weapon/ranged/energy/rifle/update_sprite()
	. = ..()
	bullet_color = polymorphs["barrel"]
	return .

/obj/item/weapon/ranged/energy/rifle/hardlight
	name = "AER13b Hardlight Rifle"
	desc_extended = "A modular model of laser rifle, capable of using different crystals to shoot beams with different effects. This one shoots a hardlight beam that pierces through people."
	ranged_damage_type = /damagetype/ranged/laser/rifle/hardlight

	projectile_speed = 26
	shoot_delay = 6

	charge_cost = 2000

	view_punch = 20

	polymorphs = list(
		"base" = COLOR_WHITE,
		"barrel" = "#FFFF00"
	)

	value = 1100

/obj/item/weapon/ranged/energy/rifle/xray
	name = "AER13c X-Ray Rifle"
	desc_extended = "A modular model of laser rifle, capable of using different crystals to shoot beams with different effects. This one shoots a x-ray beams that completely ignores armor."
	ranged_damage_type = /damagetype/ranged/laser/rifle/xray

	projectile_speed = 20
	shoot_delay = 4

	charge_cost = 2000

	view_punch = 24

	polymorphs = list(
		"base" = COLOR_WHITE,
		"barrel" = "#00FF00"
	)

	value = 1500