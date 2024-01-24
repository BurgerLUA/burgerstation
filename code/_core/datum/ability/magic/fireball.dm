/ability/magic/projectile/fireball
	name = "Fireball"
	desc = "Shoot a fireball at the target."
	icon_state = "fireball"
	cost = 10
	cooldown = 8 SECONDS

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.75 - 1

	projectile_to_shoot = /obj/projectile/magic/fireball/explosive
	damage_type = /damagetype/ranged/magic/fireball

	shoot_sound = 'sound/weapons/magic/fireball.ogg'
