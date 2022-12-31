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
		pixel_z -= 1

/obj/projectile/thrown/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)

	. = ..()

	if(.)

		var/do_bounce = TRUE

		for(var/k in src.contents)
			var/atom/movable/A = k
			if(ricochets_left <= 0 && do_bounce && A.thrown_bounce_modifier)
				do_bounce = FALSE
				var/list/face_of_impact = get_directional_offsets(old_loc,new_loc)
				var/velocity_mod = 0
				if(face_of_impact[1] || face_of_impact[2])
					var/angle_of_incidence = abs(closer_angle_difference(ATAN2(vel_x,vel_y),ATAN2(face_of_impact[1],face_of_impact[2])))
					velocity_mod = thrown_bounce_modifier*0.5 + ((angle_of_incidence/90) * thrown_bounce_modifier)*0.5
					velocity_mod = min(velocity_mod,1)
				if(velocity_mod > 0 )
					. = FALSE
					//Move one step forward.
					pixel_x_float_physical += vel_x
					pixel_y_float_physical += vel_y
					//Set the new velocity.
					vel_x *= velocity_mod * (1 - abs(face_of_impact[1])*2)
					vel_y *= velocity_mod * (1 - abs(face_of_impact[2])*2)
					//Move a step back.
					pixel_x_float_physical -= vel_x*0.5
					pixel_y_float_physical -= vel_y*0.5
					//Sync visuals.
					pixel_x_float_visual = pixel_x_float_physical
					pixel_y_float_visual = pixel_y_float_physical
					pixel_x = CEILING(pixel_x_float_visual,1)
					pixel_y = CEILING(pixel_y_float_visual,1)
					steps_allowed *= velocity_mod
					continue
				else
					. = TRUE
			if(old_loc)
				A.force_move(old_loc)
			else if(new_loc)
				A.force_move(new_loc)
			else if(src.loc)
				A.force_move(src.loc)
			A.on_thrown(owner,hit_atom)
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
	M.Translate(pixel_x % 32,pixel_y % 32)
	A.transform = M
	if(is_living(A))
		var/mob/living/L = A
		L.handle_transform(TRUE)
	else
		animate(A,transform=A.get_base_transform(),easing=CIRCULAR_EASING|EASE_OUT,time=4)
	A.set_dir(dir)
