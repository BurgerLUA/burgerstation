/obj/item/weapon/ranged/energy/hybrid/carbine
	name = "hybrid laser carbine"
	desc = "Freeze, Criminal Scum!"
	desc_extended = "A hybrid laser carbine with two firemodes, low intensity (stun) and high intensity (kill). Commonly used by security forces all over the galaxy."
	icon = 'icons/obj/item/weapons/ranged/laser/carbine_new.dmi'
	value = 1900

	company_type = "NanoTrasen"

	projectile_kill = /obj/projectile/bullet/laser/weak
	projectile_stun = /obj/projectile/bullet/laser/weak

	damage_type_kill = /damagetype/ranged/laser/carbine
	damage_type_stun = /damagetype/ranged/laser/carbine/stun

	shoot_sounds_kill = list('sound/weapons/ranged/energy/laser_carbine/kill.ogg')
	shoot_sounds_stun = list('sound/weapons/ranged/energy/laser_carbine/stun.ogg')

	bullet_color = "#FF0000"

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 2

	automatic = TRUE
	max_bursts = 3

	charge_cost = CELL_SIZE_BASIC / 120

	heat_max = 0.03

	size = SIZE_3
	weight = 14

	inaccuracy_modifier = 0.5
	movement_inaccuracy_modifier = 0
	movement_spread_base = 0.01

	rarity = RARITY_COMMON

	polymorphs = list(
		"base" = "#FFFFFF",
		"barrel" = "#FF0000"
	)

	dyeable = FALSE

	charge_icon_uses_bullet_color = TRUE

/obj/item/weapon/ranged/energy/hybrid/carbine/update_sprite()
	polymorphs["barrel"] = bullet_color
	. = ..()

/obj/item/weapon/ranged/energy/hybrid/carbine/get_static_spread()
	return 0.001

/obj/item/weapon/ranged/energy/hybrid/carbine/get_skill_spread(var/mob/living/L)
	return max(0,0.02 - (0.08 * L.get_skill_power(SKILL_RANGED)))

/obj/item/weapon/ranged/energy/hybrid/carbine/ai_core
	value_burgerbux = 1
	contraband = TRUE
	value = 0
	battery = /obj/item/powercell/recharging
	bullet_count = 1