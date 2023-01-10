/obj/projectile/thrown
	name = "thrown object"

	collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
	collision_flags_special = FLAG_COLLISION_WALKING | FLAG_COLLISION_CRAWLING

	hit_target_turf = TRUE

	impact_effect_turf = null
	impact_effect_movable = null

	muzzleflash_effect = null

	inaccuracy_modifier = 0

	plane = PLANE_PROJECTILE_NO_EFFECTS

	ricochets_left =  0 //Uses custom system.

/obj/projectile/thrown/Initialize()

	. = ..()

	steps_allowed = min(VIEW_RANGE,get_dist(start_turf,target_turf))

	pixel_z = steps_allowed


/obj/projectile/thrown/on_enter_tile(previous_loc,current_loc)

	. = ..()

	if(.)
		if(steps_current < steps_allowed*0.5)
			pixel_z += 2
		else
			pixel_z -= 2
		vel_x *= 0.9
		vel_y *= 0.9

/obj/projectile/thrown/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)

	. = ..()

	if(. && hit_atom && old_loc && new_loc)
		var/do_bounce = hit_atom != target_turf && steps_current < steps_allowed
		world.log << "HIT [hit_atom.type]"
		for(var/k in src.contents)
			var/atom/movable/A = k
			if(ricochets_left <= 0 && do_bounce && A.thrown_bounce_modifier)
				do_bounce = FALSE

				var/max_normal = max(abs(vel_x),abs(vel_y))
				var/x_normal = vel_x/max_normal
				var/y_normal = vel_y/max_normal

				var/current_loc_x = x + (pixel_x_float_physical + x_normal*TILE_SIZE) / TILE_SIZE
				var/current_loc_y = y + (pixel_y_float_physical + y_normal*TILE_SIZE) / TILE_SIZE

				var/difference_x = hit_atom.x - current_loc_x
				var/difference_y = hit_atom.y - current_loc_y

				world.log << "Diff: [difference_x], [difference_y]"

				var/impact_face_x = 0
				var/impact_face_y = 0
				if(abs(difference_x) > abs(difference_y))
					impact_face_x = difference_x > 0 ? -1 : 1
				else
					impact_face_y = difference_y > 0 ? -1 : 1

				if(impact_face_x)
					if(impact_face_x == -1)
						world.log << "LEFT"
					else
						world.log << "RIGHT"
				else
					if(impact_face_y == -1)
						world.log << "BOTTOM"
					else
						world.log << "TOP"

				var/angle_of_incidence = abs(closer_angle_difference(ATAN2(vel_x,vel_y),ATAN2(impact_face_x,impact_face_y)))
				var/velocity_mod = thrown_bounce_modifier*0.5 + ((angle_of_incidence/90) * thrown_bounce_modifier)*0.5
				velocity_mod = min(velocity_mod,1)
				if(velocity_mod > 0 )
					. = FALSE
					if(impact_face_x)
						vel_x *= -1
						pixel_x_float_physical = (hit_atom.x - src.x)*TILE_SIZE + impact_face_x*TILE_SIZE*0.5
					if(impact_face_y)
						vel_y *= -1
						pixel_y_float_physical = (hit_atom.y - src.y)*TILE_SIZE + impact_face_y*TILE_SIZE*0.5
					vel_x *= velocity_mod
					vel_y *= velocity_mod
					steps_allowed *= velocity_mod
					//current_loc = old_loc
					continue
				else
					. = TRUE
			//Below only runs if its a hit.
			A.force_move(old_loc)
			A.Move(new_loc)
			A.on_thrown(owner,hit_atom)
			animate_hit(A)
			CHECK_TICK_SAFE(75,FPS_SERVER)






/obj/projectile/thrown/Destroy()

	for(var/k in src.contents)
		CHECK_TICK_SAFE(75,FPS_SERVER)
		var/atom/movable/A = k
		if(previous_loc)
			A.force_move(previous_loc)
		else if(current_loc)
			A.force_move(current_loc)
		else
			A.force_move(src.loc)
		animate_hit(A)
		A.on_thrown(owner,null,current_loc)

	. = ..()

/obj/projectile/thrown/proc/animate_hit(var/atom/movable/A)
	var/matrix/M = A.get_base_transform()
	var/new_angle = -ATAN2(vel_x,vel_y) + 90
	M.Turn(new_angle)
	M.Translate(pixel_z + pixel_x % TILE_SIZE,pixel_y % TILE_SIZE - pixel_w)
	A.transform = M
	if(is_living(A))
		var/mob/living/L = A
		L.handle_transform(TRUE)
	else
		animate(A,transform=A.get_base_transform(),easing=CIRCULAR_EASING|EASE_OUT,time=10)
	A.set_dir(dir)
