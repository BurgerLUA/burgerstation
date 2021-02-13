/obj/item/weapon/ranged/energy/hybrid/carbine
	name = "hybrid laser carbine"
	desc = "Freeze, Criminal Scum!"
	desc_extended = "A hybrid laser carbine with two firemodes, low intensity (stun) and high intensity (kill). Commonly used by shitsecurity."
	icon = 'icons/obj/item/weapons/ranged/laser/carbine.dmi'

	projectile_kill = /obj/projectile/bullet/laser/weak
	projectile_stun = /obj/projectile/bullet/laser/weak

	damage_type_kill = /damagetype/ranged/laser/carbine
	damage_type_stun = /damagetype/ranged/laser/carbine/stun

	shoot_sounds_kill = list('sound/weapons/laser_carbine/kill.ogg')
	shoot_sounds_stun = list('sound/weapons/laser_carbine/stun.ogg')

	bullet_color = "#FF0000"

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 2

	automatic = TRUE
	max_bursts = 3

	override_icon_state = TRUE
	override_icon_state_held = TRUE

	charge_cost = CELL_SIZE_BASIC / 120

	view_punch = 6

	heat_per_shot = 0.01
	heat_max = 0.03

	size = SIZE_3
	weight = 14

	value = 600


/obj/item/weapon/ranged/energy/hybrid/carbine/update_icon()

	icon_state = initial(icon_state)
	var/icon_state_held = "held"

	if(mode)
		icon_state = "[icon_state]_kill"
		icon_state_held = "[icon_state_held]_kill"
		bullet_color = "#FF0000"
	else
		icon_state = "[icon_state]_stun"
		icon_state_held = "[icon_state_held]_stun"
		bullet_color = "#00FFFF"

	var/obj/item/powercell/PC = get_battery()

	var/charge_mod = (istype(PC) && PC.charge_current >= charge_cost) ? CEILING((PC.charge_current/PC.charge_max)*4,1) : 0

	icon_state = "[icon_state]_[charge_mod]"
	icon_state_held = "[icon_state_held]_[charge_mod]"

	icon_state_held_right = "[icon_state_held]_right"
	icon_state_held_left = "[icon_state_held]_left"

	return ..()

/obj/item/weapon/ranged/energy/hybrid/carbine/get_static_spread()
	return 0.01

/obj/item/weapon/ranged/energy/hybrid/carbine/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.08 * L.get_skill_power(SKILL_RANGED)))