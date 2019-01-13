/obj/projectile/
	name = "Projectile"

	icon = 'icons/obj/projectiles/bullet.dmi'
	icon_state = "bullet"

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

	mouse_opacity = 0

/obj/projectile/New(var/loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y)

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

	pixel_x = vel_x
	pixel_y = vel_y

	. = ..()

	update_icon()

/obj/projectile/update_icon()
	var/icon/I = icon(icon,icon_state = icon_state)
	var/new_angle = arctan(vel_x,vel_y) - 90
	I.Turn(-new_angle)
	icon = I

/obj/projectile/proc/update_projectile()

	pixel_x_float += vel_x
	pixel_y_float += vel_y

	animate(src, pixel_x = pixel_x + vel_x, pixel_y = pixel_y + vel_y, time = 1/2)

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


		if(vel_y > 0)
			if(old_turf.density_north)
				on_hit(old_turf)
				return
			if(new_turf.density_south)
				on_hit(new_turf)
				return
		else if(vel_y < 0)
			if(old_turf.density_south)
				on_hit(old_turf)
				return
			if(new_turf.density_north)
				on_hit(new_turf)
				return

		if(vel_x > 0)
			if(old_turf.density_east)
				on_hit(old_turf)
				return
			if(new_turf.density_west)
				on_hit(new_turf)
				return
		else if(vel_x < 0)
			if(old_turf.density_west)
				on_hit(old_turf)
				return
			if(new_turf.density_east)
				on_hit(new_turf)
				return

		for(var/atom/A in new_turf.contents)
			if(A == owner)
				continue

			if(A.density || is_mob(A))
				on_hit(A)
				return

		previous_loc = current_loc

/obj/projectile/proc/on_hit(var/atom/hit_atom)
	all_projectiles -= src
	del(src)