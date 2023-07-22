/obj/item/weapon/ranged/energy/halo/cov_rifle
	name = "Type-25 Directed Energy Rifle"
	desc = "Pew pew pew!"
	desc_extended = "Also known as the \"Plasma Rifle\", this weapon fires 3-shot bursts of superheated plasma."
	icon = 'icons/obj/item/weapons/ranged/laser/cov_rifle.dmi'

	projectile = /obj/projectile/bullet/laser/strong
	ranged_damage_type = /damagetype/ranged/laser/rifle/hardlight
	battery = /obj/item/powercell/recharging

	bullet_color = "#466ab6"

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 2
	//max_bursts = 3

	automatic = TRUE

	charge_cost = CELL_SIZE_ADVANCED / 100

	view_punch = 16

	shoot_sounds = list(
	'sound/weapons/covenant/plasmariflefire1.ogg',
	'sound/weapons/covenant/plasmariflefire2.ogg',
	'sound/weapons/covenant/plasmariflefire3.ogg')

	heat_per_shot = 0.01
	heat_max = 0.08

	size = SIZE_3
	weight = 6

	value = 1400

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = FALSE,
		/obj/item/attachment/barrel/laser_charger/advanced = FALSE,
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

	attachment_barrel_offset_x = 31 - 16
	attachment_barrel_offset_y = 15 - 16

	attachment_sight_offset_x = 17 - 16
	attachment_sight_offset_y = 22 - 16

	attachment_undermount_offset_x = 29 - 16
	attachment_undermount_offset_y = 12 - 16

	firing_pin = /obj/item/firing_pin/electronic/iff/covenant

/obj/item/weapon/ranged/energy/halo/cov_rifle/get_static_spread()
	if(wielded) return 0
	return 0.005

/obj/item/weapon/ranged/energy/halo/cov_rifle/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))