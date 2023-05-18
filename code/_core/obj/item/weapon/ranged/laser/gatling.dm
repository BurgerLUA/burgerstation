/obj/item/weapon/ranged/energy/gatling
	name = "L055-Prototype Gatling Laser"
	desc = "It costs 400.000 watts to fire this weapon for 12 seconds."
	desc_extended = "A behemoth of a weapon, now in laser form. Handle with care."
	icon = 'icons/obj/item/weapons/ranged/laser/gatling.dmi'
	value = 10000

	company_type = "Solarian"

	shoot_delay = 1.25

	damage_mod = 0.6

	bullet_count = 3

	projectile = /obj/projectile/bullet/laser/weak
	ranged_damage_type = /damagetype/ranged/laser/carbine

	shoot_sounds = list('sound/weapons/ranged/energy/gatling/shoot.ogg')

	bullet_color = "#FF0000"

	projectile_speed = TILE_SIZE - 1
	automatic = TRUE

	can_wield = TRUE
	wield_only = TRUE

	override_icon_state = TRUE
	override_icon_state_held = TRUE

	heat_max = 0.2

	charge_cost = CELL_SIZE_BASIC / 300

	size = SIZE_5
	weight = 40

	inaccuracy_modifier = 2
	movement_inaccuracy_modifier = 0.75
	movement_spread_base = 0.3

	value_burgerbux = 1

	rarity = RARITY_MYTHICAL

/obj/item/weapon/ranged/energy/gatling/get_static_spread(var/mob/living/L)
	return 0.05

/obj/item/weapon/ranged/energy/gatling/get_base_spread()
	return 0.2

/obj/item/weapon/ranged/energy/gatling/get_skill_spread(var/mob/living/L)
	return max(0,0.15 - (0.1 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/gatling/update_icon()

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