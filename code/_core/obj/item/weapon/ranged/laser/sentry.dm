/obj/item/weapon/ranged/energy/sentry_turret
	name = "\improper sentry"
	icon = 'icons/obj/item/weapons/ranged/laser/captain.dmi'

	projectile = /obj/projectile/bullet/firearm/rifle
	ranged_damage_type = /damagetype/ranged/bullet/rifle_556mm

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 3

	automatic = TRUE

	shoot_sounds = list('sound/weapons/smg_heavy/classic_2.ogg')

	charge_cost = 1




	heat_max = 0

	size = SIZE_3

	value = -1

	battery = /obj/item/powercell/recharging



	bullet_color = COLOR_BULLET

	inaccuracy_modifier = 1.25
	movement_spread_base = 0

/obj/item/weapon/ranged/energy/sentry_turret/get_static_spread()
	return 0.005

/obj/item/weapon/ranged/energy/sentry_turret/can_owner_shoot(var/mob/caller,var/atom/object,location,params)
	if(caller.is_player_controlled())
		return FALSE
	return ..()