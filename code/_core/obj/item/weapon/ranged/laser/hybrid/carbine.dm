/obj/item/weapon/ranged/energy/hybrid/carbine
	name = "hybrid laser carbine"
	icon = 'icons/obj/items/weapons/ranged/laser/carbine.dmi'

	projectile_kill = /obj/projectile/bullet/laser/
	projectile_stun = /obj/projectile/bullet/laser/

	damage_type_kill = "laser_carbine_kill"
	damage_type_stun = "laser_carbine_stun"

	shoot_sounds_kill = list('sounds/weapons/laser_carbine/kill.ogg')
	shoot_sounds_stun = list('sounds/weapons/laser_carbine/stun.ogg')

	projectile_speed = 31
	shoot_delay = 1

	automatic = TRUE
	max_bursts = 3

	override_icon_state = TRUE
	override_icon_state_held = TRUE

	charge_max = CELL_SIZE_ADVANCED
	charge_current = CELL_SIZE_ADVANCED
	charge_cost = CELL_SIZE_ADVANCED / 60

	view_punch = 6

/obj/item/weapon/ranged/energy/hybrid/carbine/update_icon()

	icon_state = initial(icon_state)
	var/icon_state_held = "held"

	if(mode)
		icon_state = "[icon_state]_kill"
		icon_state_held = "[icon_state_held]_kill"
	else
		icon_state = "[icon_state]_stun"
		icon_state_held = "[icon_state_held]_stun"

	var/charge_mod = charge_current >= charge_cost ? CEILING((charge_current/charge_max)*4,1) : 0

	icon_state = "[icon_state]_[charge_mod]"
	icon_state_held = "[icon_state_held]_[charge_mod]"
	icon_state_held_right = "[icon_state_held]_right"
	icon_state_held_left = "[icon_state_held]_left"

	return ..()

/obj/item/weapon/ranged/energy/hybrid/carbine/get_static_spread() //Base spread
	return 0.05

/obj/item/weapon/ranged/energy/hybrid/carbine/get_skill_spread(var/mob/living/L) //Base spread
	return 0.05 - (0.05 * L.get_skill_power(SKILL_RANGED))