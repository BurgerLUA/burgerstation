/obj/item/weapon/ranged/energy/halo/cov_rifle
	name = "Type-25 Directed Energy Rifle"
	desc = "Pew pew pew!"
	desc_extended = "Also known as the \"Plasma Rifle\", this weapon fires bursts of superheated plasma."
	icon = 'icons/obj/item/weapons/ranged/laser/cov_rifle.dmi'
	value = 2000

	damage_mod = 1.3

	company_type = "Covenant"

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/rifle

	bullet_color = "#466ab6"
	battery = /obj/item/powercell/recharging

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 3

	automatic = TRUE

	override_icon_state = TRUE
	override_icon_state_held = FALSE //TODO: FIX THIS

	charge_cost = CELL_SIZE_BASIC / 60

	shoot_sounds = list(
	'sound/weapons/halo/covenant/plasmariflefire1.ogg',
	'sound/weapons/halo/covenant/plasmariflefire2.ogg',
	'sound/weapons/halo/covenant/plasmariflefire3.ogg')

	heat_max = 0.1

	polymorphs = list(
		"base" = "#FFFFFF",
		"barrel" = "#FF0000"
	)

	size = SIZE_4
	weight = 20

	attachment_whitelist = list(
		/obj/item/attachment/barrel/charger = FALSE,
		/obj/item/attachment/barrel/compensator = FALSE,
		/obj/item/attachment/barrel/extended = FALSE,
		/obj/item/attachment/barrel/gyro = FALSE,
		/obj/item/attachment/barrel/laser_charger = TRUE,
		/obj/item/attachment/barrel/laser_charger/advanced = TRUE,
		/obj/item/attachment/barrel/suppressor = FALSE,
		/obj/item/attachment/barrel_mod/reinforced_barrel = TRUE,
		/obj/item/attachment/stock_mod/reinforced_stock = TRUE,

		/obj/item/attachment/sight/laser_sight = TRUE,
		/obj/item/attachment/sight/quickfire_adapter = TRUE,
		/obj/item/attachment/sight/red_dot = TRUE,
		/obj/item/attachment/sight/scope = FALSE,
		/obj/item/attachment/sight/scope/large = FALSE,
		/obj/item/attachment/sight/targeting_computer = TRUE,

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

	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0.5
	movement_spread_base = 0.04

	can_wield = FALSE

	rarity = RARITY_COMMON

/obj/item/weapon/ranged/energy/halo/cov_rifle/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/energy/halo/cov_rifle/get_skill_spread(var/mob/living/L)
	return max(0,0.05 - (0.02 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/halo/cov_rifle/New(var/desired_loc)
	. = ..()
	update_sprite()

/obj/item/weapon/ranged/energy/halo/cov_rifle/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_CROWBAR)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(battery)
				caller.to_chat(span("warning","You are unable to pry out \the [battery.name]."))
			else
				caller.to_chat(span("warning","There is nothing to pry out of \the [src.name]!"))
			return TRUE

	. = ..()

/obj/item/weapon/ranged/energy/halo/cov_rifle/update_overlays()

	. = ..()

	var/obj/item/powercell/PC = get_battery()

	var/true_charge = istype(PC) ? FLOOR(PC.charge_current/charge_cost, 1) / FLOOR(PC.charge_max/charge_cost, 1) : 0

	var/image/I = new/image(initial(icon),"ammo_[CEILING(true_charge * 8, 1)]")
	I.color = polymorphs["barrel"]
	add_overlay(I)

/obj/item/weapon/ranged/energy/halo/cov_rifle/insurrection
	name = "Modified Type-25 Directed Energy Rifle"
	desc = "Pew pew pew!"
	desc_extended = "Also known as the \"Plasma Rifle\", this weapon fires bursts of superheated plasma."
	icon = 'icons/obj/item/weapons/ranged/laser/cov_rifle_ins.dmi'
	company_type = "United Rebel Front"