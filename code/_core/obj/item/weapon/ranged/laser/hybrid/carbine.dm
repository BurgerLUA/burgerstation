/obj/item/weapon/ranged/laser/hybrid/carbine
	name = "hybrid laser carbine"
	icon = 'icons/obj/items/weapons/ranged/carbine.dmi'

	projectile_kill = /obj/projectile/bullet/laser/
	projectile_stun = /obj/projectile/bullet/laser/

	damage_type_kill = "laser_carbine_kill"
	damage_type_stun = "laser_carbine_stun"

	shoot_sounds_kill = list('sounds/weapons/laser_carbine/kill.ogg')
	shoot_sounds_stun = list('sounds/weapons/laser_carbine/stun.ogg')

	bullet_speed = 31
	shoot_delay = 4

	automatic = TRUE

	override_icon_state = TRUE
	override_icon_state_held = TRUE

	charge_max = 30000
	charge_current = 30000
	charge_cost = 500

	view_punch = 6

/obj/item/weapon/ranged/laser/hybrid/carbine/update_icon()

	icon_state = initial(icon_state)
	var/icon_state_held = "held"

	if(mode)
		icon_state = "[icon_state]_kill"
		icon_state_held = "[icon_state_held]_kill"
	else
		icon_state = "[icon_state]_stun"
		icon_state_held = "[icon_state_held]_stun"

	var/charge_mod = ceiling((charge_current/charge_max)*4,1)

	icon_state = "[icon_state]_[charge_mod]"
	icon_state_held = "[icon_state_held]_[charge_mod]"
	icon_state_held_right = "[icon_state_held]_right"
	icon_state_held_left = "[icon_state_held]_left"

	return ..()