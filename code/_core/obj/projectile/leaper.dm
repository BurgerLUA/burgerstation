/obj/projectile/leaper
	name = "leaper bubble"
	icon = 'icons/obj/projectiles/leaper.dmi'
	icon_state = "leaper"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

	var/last_angle

	lifetime = SECONDS_TO_DECISECONDS(8)

/obj/projectile/leaper/update_projectile(var/tick_rate=1)

	. = ..()

	if(!.)
		return .

	if(!current_loc)
		return .

	if(start_time + SECONDS_TO_DECISECONDS(2) > lifetime)
		vel_x *= 0.75
		vel_y *= 0.75
		alpha -= 10
		if(alpha <= 0)
			on_projectile_hit(current_loc)
			qdel(src)
			return FALSE
		return .


	if(abs(vel_x) > 4 && abs(vel_y) > 4)
		vel_x *= 0.95
		vel_y *= 0.95
		return .

	var/atom/target_to_track = target_atom ? target_atom : target_turf

	if(!target_to_track || target_to_track.z != src.z || target_to_track.qdeleting)
		return .

	var/desired_angle = get_angle(current_loc,target_to_track) + 90

	if(!isnum(last_angle))
		last_angle = desired_angle
	else
		desired_angle = SIMPLIFY_DEGREES(last_angle)*0.75 + SIMPLIFY_DEGREES(desired_angle)*0.25

	vel_x = (vel_x + sin(desired_angle)*2)*0.5
	vel_y = (vel_y + cos(desired_angle)*2)*0.5

	last_angle = desired_angle
