/obj/item/weapon/ranged/energy/syndicate_turret
	name = "\improper Syndicate Turret"
	icon = 'icons/obj/item/weapons/ranged/laser/captain.dmi'

	projectile = /obj/projectile/bullet/firearm/rifle
	ranged_damage_type = /damagetype/ranged/bullet/rifle_556mm

	projectile_speed = TILE_SIZE - 1
	shoot_delay = 1

	automatic = TRUE

	shoot_sounds = list('sound/weapons/smg_heavy/classic_2.ogg')

	charge_cost = 1

	view_punch = 0

	heat_per_shot = 0
	heat_max = 0

	size = SIZE_3

	value = 0

	battery = /obj/item/powercell/recharging

	firing_pin = /obj/item/firing_pin/electronic

	bullet_color = COLOR_BULLET


/obj/item/weapon/ranged/energy/syndicate_turret/get_static_spread()
	return 0.005