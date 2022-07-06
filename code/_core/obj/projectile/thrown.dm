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

/obj/projectile/thrown/on_projectile_hit(var/atom/hit_atom)

	. = ..()

	if(.)
		for(var/k in src.contents)
			CHECK_TICK(75,FPS_SERVER)
			var/atom/movable/A = k
			var/atom/hit_wall
			if(current_loc && !A.can_enter_turf(current_loc,previous_loc))
				hit_wall = current_loc
				A.force_move(previous_loc)
			else
				A.force_move(current_loc)
			animate_hit(A)
			A.on_thrown(owner,hit_atom,hit_wall)

/obj/projectile/thrown/Destroy()

	for(var/k in src.contents)
		CHECK_TICK(75,FPS_SERVER)
		var/atom/movable/A = k
		if(current_loc)
			A.force_move(current_loc)
		else
			A.force_move(previous_loc)
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
