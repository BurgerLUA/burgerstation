/atom/movable/

	step_size = TILE_SIZE
	appearance_flags = LONG_GLIDE | PIXEL_SCALE | TILE_BOUND

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	animate_movement = SLIDE_STEPS

	var/area/area //The object's area.

	var/tmp/move_dir = 0
	var/tmp/move_delay = 0

	var/movement_delay = 4 //Measured in ticks.
	var/anchored = TRUE
	var/ghost = FALSE

	var/damage_type_thrown = "thrown" //Damage type if the object is thrown. If none is provided, it will just use damage_type and double the damage.

	var/change_dir_on_move = FALSE

	var/obj/hud/inventory/grabbing_hand

	var/allow_shuttle_move = TRUE

	var/rotation_mod = 1
	var/can_rotate = FALSE

	var/next_conveyor = 0 //For conveyors.

	var/has_footsteps = FALSE

	var/throwable = TRUE

	var/value = -1 //Value in whatever currency this world uses. Used for buying and selling items.

	var/blocks_air = 0x0


/atom/movable/proc/update_collisions(var/normal,var/bullet,var/c_dir,var/a_dir,var/force = FALSE)

	. = FALSE

	if(isnum(normal) && (force || normal != collision_flags))
		collision_flags = normal
		. = TRUE

	if(isnum(bullet) && (force || collision_bullet_flags != bullet))
		collision_bullet_flags = bullet
		. = TRUE

	if(isnum(c_dir) && (force || collision_dir != c_dir))
		collision_dir = c_dir
		. = TRUE

	if(isnum(a_dir) && (force || a_dir != blocks_air))
		var/turf/simulated/T = get_turf(src)
		if(T && is_simulated(T))
			T.blocks_air &= ~blocks_air
			T.blocks_air = a_dir
			QUEUE_AIR_TURF(T)

		blocks_air = a_dir
		. = TRUE

	return .





/atom/movable/New(var/desired_loc)

	. = ..()

	if(blocks_air && is_simulated(loc))
		var/turf/simulated/T = loc
		T.has_air_blocking_atom |= NORTH | EAST | SOUTH | WEST

	return .




/atom/movable/proc/can_be_grabbed(var/atom/grabber)
	return !anchored

/atom/movable/Initialize()
	. = ..()
	if(loc)
		area = get_area(loc)
		if(area)
			area.Entered(src,null)
		else
			log_error("WARNING: For some reason, [src.name]([src.type]) didn't have an area to initialize in! (Loc: [loc.name]([loc.type].)")

	return .

/atom/movable/Destroy()
	area = null
	grabbing_hand = null
	force_move(null)
	return ..()

/atom/movable/proc/get_movement_delay()
	return movement_delay


/proc/is_valid_dir(var/direction)

	if(!direction || (direction & EAST && direction & WEST) || (direction & NORTH && direction & SOUTH))
		return FALSE

	return TRUE


/mob/living/handle_movement(var/adjust_delay = 1)

	if(move_delay <= 0 && ai)
		movement_flags = MOVEMENT_NORMAL
		move_dir = 0x0
		ai.handle_movement()

	return ..()

/atom/movable/proc/handle_movement(var/adjust_delay = 1) //Measured in ticks.

	if(move_dir && is_valid_dir(move_dir) && move_delay <= 0)
		var/final_movement_delay = get_movement_delay()
		var/atom/desired_loc = get_step(src,move_dir)
		var/list/step_offsets = list(0,0)
		if(step_size != 32)
			step_offsets = direction_to_pixel_offset(move_dir)
			desired_loc = src.loc
			final_movement_delay = 0
		move_delay = round(max(final_movement_delay,move_delay + final_movement_delay), adjust_delay ? adjust_delay : 1) //Round to the nearest tick. Counting decimal ticks is dumb.
		glide_size = move_delay ? step_size/move_delay : 1

		var/move_result = Move(desired_loc,move_dir,step_offsets[1],step_offsets[2])
		if(move_result == 0 && (move_dir in DIRECTIONS_INTERCARDINAL))
			for(var/new_dir in DIRECTIONS_CARDINAL)
				var/list/new_step_offsets = list(0,0)
				var/atom/new_desired_loc = get_step(src,new_dir)
				if(step_size != 32)
					new_step_offsets = direction_to_pixel_offset(move_dir)
					new_desired_loc = src.loc
				if((new_dir & move_dir) && Move(new_desired_loc,new_dir,new_step_offsets[1],new_step_offsets[2]))
					return TRUE

		return TRUE
	else
		if(adjust_delay)
			move_delay = move_delay - adjust_delay
		return FALSE

/atom/movable/proc/force_move(var/atom/new_loc)

	if(loc)
		loc.Exited(src, new_loc)

	var/atom/old_loc = loc
	loc = new_loc

	if(loc)
		loc.Entered(src, old_loc)
		if(loc)
			for(var/atom/movable/AM in loc.contents)
				if(AM == src)
					continue
				AM.Crossed(src)

	return TRUE

/atom/movable/Bump(var/atom/obstacle,var/Dir=0)

	if(Dir && ismovable(obstacle) && src.loc != obstacle)
		var/atom/movable/M = obstacle
		if(!M.anchored && (!grabbing_hand || obstacle != grabbing_hand.owner))
			M.glide_size = src.glide_size
			return M.Move(get_step(M,Dir),Dir)

	return FALSE

/atom/movable/Move(var/atom/NewLoc,Dir=0,desired_step_x=0,desired_step_y=0,var/silent=FALSE)

	var/stepped_x = 0
	var/stepped_y = 0

	//Try Pixel Movement x
	if(desired_step_x)
		if(step_x + desired_step_x >= TILE_SIZE)
			NewLoc = get_step(NewLoc,EAST)
			stepped_x = TILE_SIZE
		else if(step_x + desired_step_x < 0)
			NewLoc = get_step(NewLoc,WEST)
			stepped_x = -TILE_SIZE

	//Try Pixel Movement y
	if(desired_step_y)
		if(step_y + desired_step_y >= TILE_SIZE)
			NewLoc = get_step(NewLoc,NORTH)
			stepped_y = TILE_SIZE

		else if(step_y + desired_step_y < 0)
			NewLoc = get_step(NewLoc,SOUTH)
			stepped_y = -TILE_SIZE

	if(istype(src.loc,/obj/projectile))
		return FALSE

	if(change_dir_on_move && Dir)
		set_dir(Dir)

	if(!NewLoc)
		return FALSE

	if(!loc)
		return FALSE

	var/atom/OldLoc = loc

	var/real_dir = get_dir(loc,NewLoc)

	//TRY: Exit the turf.
	if(!OldLoc.Exit(src,NewLoc) && !Bump(OldLoc,real_dir))
		return FALSE

	//TRY: Exit the contents.
	for(var/atom/movable/M in OldLoc.contents)
		if(M == src)
			continue
		if(!M.Uncross(src,NewLoc,OldLoc)) //Placing bump here is a bad idea. Easy way to cause infinite loops.
			return FALSE

	//TRY: Enter the contents.
	if(!NewLoc.Enter(src,OldLoc) && !Bump(NewLoc,real_dir))
		return FALSE

	//TRY: Enter the contents.
	for(var/atom/movable/M in NewLoc.contents)
		if(M == src)
			continue
		if(!M.Cross(src,NewLoc,OldLoc) && !Bump(M,real_dir))
			return FALSE

	if(OldLoc != NewLoc)
		//DO: Exited the turf.
		OldLoc.Exited(src,NewLoc)

		//DO: Make a footstep sound.
		if(!silent && has_footsteps && OldLoc.footstep_id && all_footsteps[OldLoc.footstep_id])
			var/footstep/F = all_footsteps[OldLoc.footstep_id]
			F.on_step(OldLoc,src,TRUE)

		//DO: Exited the contents.
		for(var/atom/A in OldLoc.contents)
			if(A == src)
				continue
			A.Uncrossed(src,NewLoc,OldLoc)

	if(desired_step_x)
		step_x += desired_step_x - stepped_x

	if(desired_step_y)
		step_y += desired_step_y - stepped_y

	if(loc == OldLoc && loc != NewLoc)
		loc = NewLoc

		//DO: Entered the turf.
		NewLoc.Entered(src,OldLoc)

		//DO: Make a footstep sound.
		if(!silent && has_footsteps && NewLoc.footstep_id && all_footsteps[NewLoc.footstep_id])
			var/footstep/F = all_footsteps[NewLoc.footstep_id]
			F.on_step(NewLoc,src,FALSE)

		//DO: Enter the contents.
		for(var/atom/A in NewLoc.contents)
			if(A == src)
				continue
			A.Crossed(src,NewLoc,OldLoc)

	return TRUE
