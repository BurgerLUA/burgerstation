/obj/projectile/
	name = "Projectile"

	var/vel_x = 0 //X velocity, in pixels per decisecond
	var/vel_y = 0 //Y velocity in pixels per decisecond

	var/pixel_x_float = 0
	var/pixel_y_float = 0

	var/imaginary_x = 0
	var/imaginary_y = 0

	var/atom/owner //Who is the one who shot the weapon?
	var/atom/weapon //What weapon did the projectile come from?

	var/previous_loc
	var/current_loc

	var/last_loc_x = 0
	var/last_loc_y = 0

	var/shoot_x = 0
	var/shoot_y = 0

	mouse_opacity = 0

	layer = LAYER_PROJECTILE

	plane = 4

	var/lifetime = 100

	var/turf/target_turf

	var/only_hit_target_turf = FALSE

/obj/projectile/New(var/loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf)

	owner = desired_owner
	weapon = desired_weapon

	vel_x = desired_vel_x
	vel_y = desired_vel_y

	imaginary_x = x
	imaginary_y = y

	all_projectiles += src

	previous_loc = loc

	last_loc_x = x
	last_loc_y = y

	//pixel_x = vel_x
	//pixel_y = vel_y

	shoot_x = desired_shoot_x
	shoot_y = desired_shoot_y

	target_turf = desired_turf

	. = ..()

	update_icon()

	var/matrix/M = matrix()
	M.Translate(vel_x*lifetime,vel_y*lifetime)
	animate(src, transform = M, time = lifetime*0.5)
	//animate(src, pixel_x = pixel_x + vel_x*lifetime, pixel_y = pixel_y + vel_y*lifetime, time = lifetime*0.5)

/obj/projectile/update_icon()
	var/icon/I = icon(icon,icon_state = icon_state)
	var/new_angle = arctan(vel_x,vel_y) - 90
	I.Turn(-new_angle)
	icon = I

/obj/projectile/proc/update_projectile()

	pixel_x_float += vel_x
	pixel_y_float += vel_y

	var/current_loc_x = x + floor(pixel_x_float / TILE_SIZE)
	var/current_loc_y = y + floor(pixel_y_float / TILE_SIZE)

	if(last_loc_x != current_loc_x || last_loc_x != current_loc_y)

		current_loc = locate(current_loc_x,current_loc_y,z)

		if(!is_turf(previous_loc))
			on_hit(previous_loc)
			return

		if(!is_turf(src.loc))
			on_hit(src.loc)
			return

		var/turf/new_turf = current_loc
		var/turf/old_turf = previous_loc

		if(!previous_loc || !current_loc)
			on_hit(src)
			return FALSE

		if(only_hit_target_turf && current_loc == target_turf)
			on_hit(current_loc)
			return

		if(!new_turf.allow_bullet_pass)

			if(new_turf.density)
				on_hit(new_turf)
				return

			if(vel_y > 0)
				if(!old_turf.allow_bullet_pass && old_turf.density_north)
					on_hit(old_turf)
					return
				if(new_turf.density_south)
					on_hit(new_turf)
					return
			else if(vel_y < 0)
				if(!old_turf.allow_bullet_pass && old_turf.density_south)
					on_hit(old_turf)
					return
				if(new_turf.density_north)
					on_hit(new_turf)
					return

			if(vel_x > 0)
				if(!old_turf.allow_bullet_pass && old_turf.density_east)
					on_hit(old_turf)
					return
				if(new_turf.density_west)
					on_hit(new_turf)
					return
			else if(vel_x < 0)
				if(!old_turf.allow_bullet_pass && old_turf.density_west)
					on_hit(old_turf)
					return
				if(new_turf.density_east)
					on_hit(new_turf)
					return

		for(var/atom/A in new_turf.contents)
			if(A == owner)
				continue

			if(A.density || is_living(A))
				if(on_hit(A))
					return

		previous_loc = current_loc

/obj/projectile/proc/on_hit(var/atom/hit_atom)
	all_projectiles -= src
	post_on_hit(hit_atom)
	del(src)
	return TRUE

/obj/projectile/proc/post_on_hit(var/atom/hit_atom)
	return TRUE