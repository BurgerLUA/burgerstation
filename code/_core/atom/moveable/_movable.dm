/atom/movable/

	step_size = TILE_SIZE
	appearance_flags = LONG_GLIDE | PIXEL_SCALE | TILE_BOUND

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	animate_movement = SLIDE_STEPS

	var/area/area //The object's area.

	var/tmp/move_dir = 0x0
	var/tmp/move_dir_last = 0x0 //Used for momentum and speed.
	var/tmp/first_move_dir = 0x0 //The first movement key pressed. Only used for mobs.
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

	var/has_footsteps = FALSE

/atom/movable/proc/handle_footsteps(var/turf/T,var/list/footsteps_to_use,var/enter=TRUE)

	if(!enter)
		return FALSE //Only for advanced types

	for(var/k in footsteps_to_use)
		if(!k)
			continue
		var/footstep/F = SSfootstep.all_footsteps[k]
		if(F.has_footprints)
			var/type_to_use = enter ? /obj/effect/footprint/emboss/ : /obj/effect/footprint/emboss/exit
			var/obj/effect/footprint/emboss/P = new type_to_use(T,src.dir,TRUE,TRUE)
			P.color = F.footprint_color
			P.alpha = F.footprint_alpha
			INITIALIZE(P)
			FINALIZE(P)
		if(length(F.footstep_sounds))
			play(pick(F.footstep_sounds), T, volume = 50, sound_setting = SOUND_SETTING_FOOTSTEPS, pitch = 1 + RAND_PRECISE(-F.variation_pitch,F.variation_pitch))

/atom/movable/proc/get_footsteps(var/list/original_footsteps,var/enter=TRUE)
	return original_footsteps

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

/atom/movable/proc/can_be_grabbed(var/atom/grabber,var/messages=TRUE)

	if(grabber == src)
		if(messages && is_living(grabber))
			var/mob/living/L = grabber
			L.to_chat(span("warning","You can't grab yourself! ERP is against the rules!"))
		return FALSE

	if(anchored)
		if(messages && is_living(grabber))
			var/mob/living/L = grabber
			L.to_chat(span("warning","\The [src.name] is secured firmly to the ground!"))
		return FALSE

	return TRUE

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

	/*
	if(!direction || (direction & EAST && direction & WEST) || (direction & NORTH && direction & SOUTH))
		return FALSE
	*/

	if(direction - (NORTH + EAST + SOUTH + WEST) > 0)
		return FALSE

	return TRUE


