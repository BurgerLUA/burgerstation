/obj/item/weapon/ranged/energy/opticor
	name = "\improper Opticor"
	desc = "Tenno, Do you think me a weeb?"
	desc_extended = "Blasts so much energy in such an unstable energy bubble that the first thing it hits will violently explode. Kinda like a mantis shrimps punch, but with lasers."
	icon = 'icons/obj/item/weapons/ranged/laser/opticor.dmi'
	value = 8000

	company_type = "NanoTrasen"

	bullet_color = "#FFFFFF"

	projectile = /obj/projectile/bullet/laser/opticor
	ranged_damage_type = /damagetype/ranged/laser/rifle/opticor

	view_punch_mod = 2.5
	
	projectile_speed = 62
	shoot_delay = 25

	bullet_count = 3

	automatic = FALSE

	can_wield = TRUE
	wield_only = TRUE

	battery = /obj/item/powercell/recharging

	override_icon_state = TRUE
	override_icon_state_held = TRUE

	charge_cost = CELL_SIZE_BASIC / 16

	attachment_whitelist = list()

	shoot_sounds = list('sound/weapons/laser_sniper/shoot.ogg')

	heat_max = 0.2

	ai_heat_sensitivity = 2

	zoom_mul = 8

	inaccuracy_modifier = 0.1
	movement_inaccuracy_modifier = 4
	movement_spread_base = 0.4

	size = SIZE_5
	weight = 36

	contraband = TRUE

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



		/obj/item/attachment/undermount/angled_grip = FALSE,
		/obj/item/attachment/undermount/bipod = FALSE,
		/obj/item/attachment/undermount/burst_adapter = FALSE,
		/obj/item/attachment/undermount/vertical_grip = FALSE
	)

/obj/item/weapon/ranged/energy/opticor/get_static_spread()
	return 0

/obj/item/weapon/ranged/energy/opticor/get_skill_spread(var/mob/living/L)
	return max(0,0.005 - (0.01 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/opticor/update_icon()

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


/obj/item/weapon/ranged/energy/opticor/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_CROWBAR)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(battery)
				caller.to_chat(span("warning","You cant actually seem to find a slot to pry out any battery!"))
			else
				caller.to_chat(span("warning","There is nothing to pry out of \the [src.name]!"))
			return TRUE

	. = ..()