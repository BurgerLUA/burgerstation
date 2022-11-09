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

/obj/projectile/thrown/on_projectile_hit(var/atom/hit_atom,var/turf/old_loc,var/turf/new_loc)

	. = ..()

	if(.)
		for(var/k in src.contents)
			var/atom/movable/A = k
			if(hit_atom.density)
				A.force_move(old_loc ? old_loc : src.loc)
			else
				A.force_move(new_loc ? new_loc : src.loc)
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
