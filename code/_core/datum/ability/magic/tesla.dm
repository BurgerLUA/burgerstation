/ability/magic/projectile/tesla
	name = "tesla ball"
	desc = "Shoot a tesla ball at the target."
	icon_state = "tesla"
	cost = 10
	cooldown = 10 SECONDS

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.1 - 1

	projectile_to_shoot = /obj/projectile/magic/tesla
	damage_type = /damagetype/ranged/magic/tesla

	shoot_sound = 'sound/weapons/magic/fireball.ogg'
