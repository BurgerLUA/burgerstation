/obj/item/weapon/ranged/energy/clockwork_turret
	name = "\improper Clockwork Turret"
	icon = 'icons/obj/item/weapons/ranged/laser/captain.dmi'

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/carbine

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 3

	automatic = TRUE

	shoot_sounds = list('sound/weapons/laser_carbine/kill.ogg')

	charge_cost = 1




	heat_max = 0

	size = SIZE_3

	value = -1

	battery = /obj/item/powercell/recharging



	bullet_color = COLOR_PURPLE

	inaccuracy_modifier = 1.25
	movement_spread_base = 0

/obj/item/weapon/ranged/energy/clockwork_turret/get_static_spread()
	return 0.003

/obj/item/weapon/ranged/energy/clockwork_turret/can_owner_shoot(var/mob/caller,var/atom/object,location,params)
	if(caller.is_player_controlled())
		return FALSE
	return ..()