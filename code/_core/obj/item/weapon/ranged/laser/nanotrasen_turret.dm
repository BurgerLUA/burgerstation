/obj/item/weapon/ranged/energy/nanotrasen_turret
	name = "\improper NanoTrasen Turret"
	icon = 'icons/obj/item/weapons/ranged/laser/captain.dmi'

	projectile = /obj/projectile/bullet/laser
	ranged_damage_type = /damagetype/ranged/laser/rifle

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 3

	automatic = TRUE

	shoot_sounds = list('sound/weapons/ranged/energy/laser_carbine/kill.ogg')

	charge_cost = 1




	heat_max = 0

	size = SIZE_3

	value = 0

	battery = /obj/item/powercell/recharging



	bullet_color = "#FF0000"

	inaccuracy_modifier = 1.25
	movement_spread_base = 0

/obj/item/weapon/ranged/energy/nanotrasen_turret/get_static_spread()
	return 0.003

/obj/item/weapon/ranged/energy/nanotrasen_turret/can_owner_shoot(var/mob/activator,var/atom/object,location,params)
	if(activator.is_player_controlled())
		return FALSE
	return ..()