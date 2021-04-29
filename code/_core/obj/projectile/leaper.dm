/obj/projectile/leaper
	name = "leaper bubble"
	icon = 'icons/obj/projectiles/leaper.dmi'
	icon_state = "leaper"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID

/obj/projectile/leaper/update_projectile(var/tick_rate=1)

	. = ..()

	if(!current_loc)
		return .

	var/atom/target_to_track = target_atom ? target_atom : target_turf

	if(!target_to_track || target_to_track.z != src.z || target_to_track.qdeleting)
		on_projectile_hit(current_loc ? current_loc : src.loc)
		return .

	var/desired_angle = get_angle(current_loc,target_to_track) + 90

	vel_x = (vel_x + sin(desired_angle)*4)*0.5
	vel_y = (vel_y + cos(desired_angle)*4)*0.5

