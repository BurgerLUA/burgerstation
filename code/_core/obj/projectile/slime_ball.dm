/obj/projectile/slime_ball
	name = "slime ball"
	icon = 'icons/obj/projectiles/magic.dmi'
	icon_state = "slime_ball_tri"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	lifetime = SECONDS_TO_DECISECONDS(4)


/obj/projectile/slime_ball/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)

	. = ..()

	if(. && hit_atom && new_loc && icon_state == "slime_ball_tri")
		var/base_angle = MODULUS(ATAN2(vel_x,vel_y) + 90,360)
		for(var/i=-1,i<=1,i+=2)
			var/desired_vel_x = sin(base_angle + i*45 + 180)*(TILE_SIZE-1)*0.1
			var/desired_vel_y = cos(base_angle + i*45 + 180)*(TILE_SIZE-1)*0.1
			var/obj/projectile/slime_ball/SB = new(
				new_loc,
				owner,
				weapon,
				desired_vel_x,
				desired_vel_y,
				shoot_x,
				shoot_y,
				null,
				damage_type,
				null,
				color,
				blamed,
				damage_multiplier,
				iff_tag,
				loyalty_tag,
				inaccuracy_modifier,
				0
			)
			SB.icon_state = "slime_ball"
			SB.projectile_blacklist += hit_atom
			INITIALIZE(SB)
			FINALIZE(SB)