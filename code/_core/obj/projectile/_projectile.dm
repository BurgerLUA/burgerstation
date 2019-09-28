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
	var/atom/blamed //Who should we blame for the damage?

	var/previous_loc
	var/current_loc

	var/last_loc_x = 0
	var/last_loc_y = 0

	var/shoot_x = 0
	var/shoot_y = 0

	mouse_opacity = 0

	layer = LAYER_PROJECTILE

	plane = PLANE_EFFECT

	var/start_time = 0
	var/lifetime = SECONDS_TO_DECISECONDS(60) //Just in case.

	var/turf/target_turf
	var/atom/target_atom

	var/hit_target_turf = FALSE

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	var/obj/effect/temp/impact/impact_effect_turf
	var/obj/effect/temp/impact/impact_effect_movable

	var/bullet_color = "#FFFFFF"

	var/steps_current = 0
	var/steps_allowed = 0

/obj/projectile/New(var/loc,var/atom/desired_owner,var/atom/desired_weapon,var/desired_vel_x,var/desired_vel_y,var/desired_shoot_x = 0,var/desired_shoot_y = 0, var/turf/desired_turf, var/desired_damage_type, var/desired_target, var/desired_color, var/desired_blamed)

	owner = desired_owner
	weapon = desired_weapon
	if(desired_damage_type)
		damage_type = desired_damage_type

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

	target_atom = desired_target

	target_turf = desired_turf

	bullet_color = desired_color

	if(desired_blamed)
		blamed = desired_blamed
	else
		blamed = owner

	. = ..()

	update_icon()

	/*
	var/matrix/M = matrix()
	M.Translate(vel_x*lifetime,vel_y*lifetime)
	animate(src, transform = M, time = lifetime*0.5)
	*/

	return .

/obj/projectile/update_icon()
	var/icon/I = icon(icon,icon_state = icon_state)
	var/new_angle = arctan(vel_x,vel_y) - 90
	I.Turn(-new_angle)
	icon = I

/obj/projectile/proc/update_projectile() //This runs every 0.5 deciseconds.

	steps_current += 1

	start_time += 0.5

	if(steps_allowed && steps_allowed <= steps_current && current_loc)
		on_hit(current_loc)
		return FALSE

	if(lifetime <= start_time && current_loc)
		on_hit(current_loc)
		return FALSE

	pixel_x_float += vel_x
	pixel_y_float += vel_y

	var/current_loc_x = x + floor(pixel_x_float / TILE_SIZE)
	var/current_loc_y = y + floor(pixel_y_float / TILE_SIZE)

	if(last_loc_x != current_loc_x || last_loc_x != current_loc_y)

		current_loc = locate(current_loc_x,current_loc_y,z)

		var/matrix/M = matrix()
		M.Translate(pixel_x_float,pixel_y_float)
		animate(src, transform = M, time = 0.50)

		for(var/mob/MO in contents)
			if(MO.client)
				animate(MO.client,pixel_x = pixel_x_float, pixel_y = pixel_y_float, time = 0.5)

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

		if(!new_turf.allow_bullet_pass && new_turf.collision_flags & FLAG_COLLISION_REAL)

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

		var/area/A2 = get_area(new_turf)

		for(var/atom/A in new_turf.contents)

			if(A == src)
				continue

			if(A == owner)
				continue

			if(A.type == src.type)
				continue

			if(is_projectile(A))
				continue

			if(A2.safe && is_player(owner) && (is_player(A) || is_unique(A)))
				continue

			if(src.collision_bullet_flags & A.collision_bullet_flags)
				if(on_hit(A))
					return

		if(hit_target_turf && current_loc == target_turf)
			on_hit(current_loc)
			return

		previous_loc = current_loc

/obj/projectile/proc/on_hit(var/atom/hit_atom)
	all_projectiles -= src
	post_on_hit(hit_atom)
	qdel(src)
	return TRUE

/obj/projectile/proc/post_on_hit(var/atom/hit_atom)

	for(var/mob/MO in contents)
		if(MO.client)
			MO.client.pixel_x = vel_x
			MO.client.pixel_y = vel_y
			animate(MO.client,pixel_x = 0, pixel_y = 0, time = SECONDS_TO_DECISECONDS(2))

	if(impact_effect_turf && is_turf(hit_atom))
		var/tiles_traveled_x = floor(pixel_x_float / TILE_SIZE)
		var/tiles_traveled_y = floor(pixel_y_float / TILE_SIZE)
		var/desired_pixel_x = pixel_x_float - tiles_traveled_x*TILE_SIZE
		var/desired_pixel_y = pixel_y_float - tiles_traveled_y*TILE_SIZE
		new impact_effect_turf(get_turf(hit_atom),SECONDS_TO_DECISECONDS(60),desired_pixel_x,desired_pixel_y,bullet_color)

	else if(impact_effect_movable && is_movable(hit_atom))
		var/tiles_traveled_x = floor(pixel_x_float / TILE_SIZE)
		var/tiles_traveled_y = floor(pixel_y_float / TILE_SIZE)
		var/desired_pixel_x = pixel_x_float - tiles_traveled_x*TILE_SIZE
		var/desired_pixel_y = pixel_y_float - tiles_traveled_y*TILE_SIZE
		new impact_effect_movable(get_turf(hit_atom),SECONDS_TO_DECISECONDS(60),desired_pixel_x,desired_pixel_y,bullet_color)

	return TRUE