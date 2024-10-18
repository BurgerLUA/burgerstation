//Honestly, its probably a bad idea to make magic into abilities.


/ability/projectile/fireball
	name = "Fireball"
	desc = "Shoot a fireball at the target."
	icon_state = "dash"
	cost = 10
	cooldown = SECONDS_TO_DECISECONDS(3)

	category = "Fireball"

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.75 - 1

	projectile = /obj/projectile/magic/fireball
	damage_type = /damagetype/ranged/magic/fireball

	shoot_sound = 'sound/weapons/magic/fireball.ogg'

/ability/projectile/fireball/plus
	name = "Fireball Plus"
	desc = "Shoot a fireball at the target. Explodes on impact."
	icon_state = "dash"
	cost = 40
	cooldown = SECONDS_TO_DECISECONDS(4)

	category = "Fireball"

	bullet_count = 1
	projectile_speed = TILE_SIZE*0.75 - 1

	projectile = /obj/projectile/magic/fireball
	damage_type = /damagetype/ranged/magic/fireball/explosive

	shoot_sound = 'sound/weapons/magic/fireball.ogg'