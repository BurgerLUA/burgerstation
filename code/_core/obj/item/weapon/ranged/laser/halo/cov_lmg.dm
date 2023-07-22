/obj/item/weapon/ranged/energy/halo/cov_lmg
	name = "Type-51 Plasma Repeater"
	desc = "Pew pew pew!"
	desc_extended = "The Type-51 Directed Energy Rifle, more commonly known as the plasma repeater, is a plasma-based directed-energy weapon used by the Covenant, issued to Sangheili as well as Jiralhanae shock troops."
	icon = 'icons/obj/item/weapons/ranged/laser/cov_lmg.dmi'

	projectile = /obj/projectile/bullet/laser/strong
	ranged_damage_type = /damagetype/ranged/laser/rifle/hardlight
	battery = /obj/item/powercell/recharging/big
	item_slot = SLOT_TORSO_B
	worn_layer = LAYER_MOB_CLOTHING_BACK

	bullet_color = "#466ab6"

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 1.5

	automatic = TRUE
	can_wield = TRUE
	wield_only = TRUE

	charge_cost = CELL_SIZE_ADVANCED / 130

	view_punch = 16

	shoot_sounds = list(
	'sound/weapons/covenant/plasmarepeaterfire1.ogg',
	'sound/weapons/covenant/plasmarepeaterfire2.ogg',
	'sound/weapons/covenant/plasmarepeaterfire3.ogg')

	heat_per_shot = 0.01
	heat_max = 0.06

	size = SIZE_3
	weight = 6

	value = 2000

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

/obj/item/weapon/ranged/energy/halo/cov_lmg/get_static_spread()
	if(wielded) return 0
	return 0.005

/obj/item/weapon/ranged/energy/halo/cov_lmg/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.04 * L.get_skill_power(SKILL_RANGED)))