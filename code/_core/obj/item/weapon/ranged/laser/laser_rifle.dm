/obj/item/weapon/ranged/energy/rifle
	name = "AER13 Laser Rifle"
	desc = "Pew pew pew!"
	desc_extended = "A modular model of laser rifle, capable of using different crystals to shoot beams with different effects. This one is the standard beam."
	icon = 'icons/obj/item/weapons/ranged/laser/modular.dmi'

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/rifle

	bullet_color = "#FF0000"

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 2

	automatic = TRUE

	override_icon_state = TRUE
	override_icon_state_held = FALSE //TODO: FIX THIS

	charge_cost = CELL_SIZE_BASIC / 60

	view_punch = 16

	shoot_sounds = list('sound/weapons/laser_rifle/shoot.ogg')

	heat_per_shot = 0.01
	heat_max = 0.06

	polymorphs = list(
		"base" = "#FFFFFF",
		"barrel" = "#FF0000"
	)

	size = SIZE_4
	weight = 14

	value = 900

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = TRUE,
		/obj/item/attachment/barrel/suppressor = FALSE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = TRUE,
		/obj/item/attachment/sight/scope/large = TRUE,
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

	attachment_undermount_offset_x = 29 - 16
	attachment_undermount_offset_y = 12 - 16

/obj/item/weapon/ranged/energy/rifle/get_static_spread()
	if(wielded) return 0
	return 0.0005

/obj/item/weapon/ranged/energy/rifle/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.02 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/rifle/New(var/desired_loc)
	. = ..()
	update_sprite()
	return .

/obj/item/weapon/ranged/energy/rifle/update_overlays()

	var/obj/item/powercell/PC = get_battery()

	var/true_charge = istype(PC) ? FLOOR(PC.charge_current/charge_cost, 1) / FLOOR(PC.charge_max/charge_cost, 1) : 0

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
	shoot_delay = 2.5

	charge_cost = CELL_SIZE_BASIC / 50

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
	shoot_delay = 3

	charge_cost = CELL_SIZE_BASIC / 50

	view_punch = 24

	polymorphs = list(
		"base" = COLOR_WHITE,
		"barrel" = "#00FF00"
	)

	value = 1500

/obj/item/weapon/ranged/energy/rifle/xray/deathsquad
	name = "AER13c-D X-Ray Rifle"
	desc_extended = "A modular model of laser rifle, capable of using different crystals to shoot beams with different effects. This one shoots a x-ray beams that completely ignores armor. This one has a phoron crystal, and a special fusion battery that charges over time."

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 1.5

	view_punch = 30

	polymorphs = list(
		"base" = "#EEEEEE",
		"barrel" = "#FF00DC"
	)

	battery = /obj/item/powercell/recharging

	value = 2000

/obj/item/weapon/ranged/energy/rifle/xray/deathsquad/Generate()

	. = ..()

	attachment_undermount = new/obj/item/attachment/undermount/angled_grip(src)
	INITIALIZE(attachment_undermount)
	GENERATE(attachment_undermount)
	FINALIZE(attachment_undermount)

	attachment_barrel = new /obj/item/attachment/barrel/laser_charger(src)
	INITIALIZE(attachment_barrel)
	GENERATE(attachment_barrel)
	FINALIZE(attachment_barrel)

	update_attachment_stats()
	update_sprite()

	return .
