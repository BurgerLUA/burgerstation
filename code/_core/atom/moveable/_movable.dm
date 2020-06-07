/atom/movable/

	step_size = TILE_SIZE
	appearance_flags = LONG_GLIDE | PIXEL_SCALE | TILE_BOUND

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	animate_movement = SLIDE_STEPS

	var/area/area //The object's area.

	var/tmp/move_dir = 0
	var/tmp/move_dir_last = 0 //Used for momentum.
	var/tmp/move_delay = 0

	var/movement_delay = 4 //Measured in ticks.
	var/anchored = TRUE
	var/ghost = FALSE

	var/damage_type_thrown = /damagetype/thrown //Damage type if the object is thrown. If none is provided, it will just use damage_type and double the damage.

	var/change_dir_on_move = FALSE

	var/obj/hud/inventory/grabbing_hand //What is grabbing this?

	var/allow_shuttle_move = TRUE

	var/rotation_mod = 1
	var/can_rotate = FALSE

	var/next_conveyor = 0 //For conveyors.

	var/has_footsteps = FALSE
	var/footstep_override_id //If this var is defined, it will always play these footstep sounds instead, regardless of the object's footstep id.

	var/throwable = TRUE

	var/value = -1 //Value in whatever currency this world uses. Used for buying and selling items.

	var/blocks_air = 0x0

	var/acceleration_value = 0 //No touch.

	//These values affect the acceleration and deceleration rates. Higher values means it's faster. Acceleration is capped at 100, rounded to the nearest 0.01.
	var/acceleration = 10
	var/deceleration = 10

	//How much acceleration actually affects movement.
	//1 means that you'll be double your normal movespeed when you first move. 0.5 means one plus half. 2 means one plus double. 0 means disabled.
	var/acceleration_mod = 0
	var/use_momentum = FALSE //Acceleration uses momentum.



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
			T.blocks_air |= a_dir
			QUEUE_AIR_TURF(T)
		blocks_air = a_dir
		. = TRUE
	else if(force)
		var/turf/simulated/T = get_turf(src)
		T.blocks_air |= blocks_air
		if(T && is_simulated(T))
			QUEUE_AIR_TURF(T)

	return .

/atom/movable/proc/can_be_grabbed(var/atom/grabber)
	return !anchored

/atom/movable/Initialize()

	if(loc)
		area = get_area(loc)
		if(area)
			area.Entered(src,null)
		else
			CRASH_SAFE("ERROR: [get_debug_name()] didn't have an area to initialize in! (Loc: [loc.get_debug_name()].)")

		if(blocks_air && is_simulated(loc))
			var/turf/simulated/T = loc
			T.blocks_air |= blocks_air
	else
		CRASH_SAFE("ERROR: [get_debug_name()] didn't have a loc to initialize in!")

	return ..()

/atom/movable/Destroy()
	area = null
	grabbing_hand = null
	force_move(null)
	return ..()

/proc/is_valid_dir(var/direction)

	if(!direction || (direction & EAST && direction & WEST) || (direction & NORTH && direction & SOUTH))
		return FALSE

	return TRUE


