/atom/movable/

	vis_flags = VIS_INHERIT_ID

	step_size = TILE_SIZE

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	animate_movement = SLIDE_STEPS

	var/tmp/move_dir = 0x0
	var/tmp/move_dir_last = 0x0 //Used for momentum and speed.
	var/tmp/first_move_dir = 0x0 //The first movement key pressed. Only used for mobs.
	var/tmp/next_move = 0 //How long until you can move again, in ticks.

	var/thrown_bounce_modifier = 0.5 //Set to a value to above 1 to make this object bounce. 1 will generally cause it to bounce backwards at its current velocity. Values above 1 are super bouncy.

	// var/momentum_speed = 0 //Tiles per second. Maximum 10.
	// var/momentum_dir = 0x0

	var/size = SIZE_0

	var/movement_delay = 4 //Measured in ticks.
	var/anchored = 1 // 1 = Anchored to the turf. 2 = Anchored to the universe and will never move.
	var/ghost = FALSE

	var/damage_type_thrown //Damage type if the object is thrown. If none is provided, it will just use damage_type and double the damage.

	var/change_dir_on_move = FALSE

	var/obj/hud/inventory/grabbing_hand //What inventory is grabbing this?

	var/rotation_mod = 1
	var/can_rotate = FALSE

	var/next_conveyor = 0 //For conveyors.

	var/throwable = TRUE

	var/value = 0 //Value in whatever currency this world uses. Used for buying and selling items.

	var/acceleration_value = 0 //No touch.

	//These values affect the acceleration and deceleration rates. Higher values means it's faster. Acceleration is capped at 100, rounded to the nearest 0.01.
	var/acceleration = 10
	var/deceleration = 10

	//How much acceleration actually affects movement.
	//1 means that you'll be double your normal move delay when you first move. 0.5 means one plus half. 2 means one plus double. 0 means disabled.
	var/acceleration_mod = 0
	var/use_momentum = FALSE //Acceleration uses momentum.

	var/value_last = 0//Last value calculated via calculation

	var/is_moving = TRUE

	var/obj/light_sprite/light_sprite
	var/list/obj/light_sprite/light_sprite_sources //Doesn't need to be qdeled

	var/allow_path = FALSE //Set to true to allow node checking to pass this object.

	var/can_be_bumped = TRUE

	var/enable_chunk_handling = FALSE
	var/enable_chunk_clean = FALSE

	var/dir_offset = TILE_SIZE

	var/abstract = FALSE

/atom/movable/PreDestroy()
	if(enable_chunk_handling && SSchunk.initialized)
		var/turf/T = is_turf(loc) ? loc : null
		if(T)
			var/chunk/C = CHUNK(T)
			src.on_chunk_cross(C,null)
	QDEL_NULL(light_sprite)
	. = ..()

/atom/movable/Destroy()
	light_sprite_sources?.Cut()
	vis_contents?.Cut()
	grabbing_hand = null
	. = ..()

/atom/movable/PostDestroy()
	. = ..()
	src.force_move(null)
	if(src.loc)
		log_error("Warning: force_move(null) failed on [src.get_debug_name()] while qdeleting!")
		src.loc = null

/atom/movable/proc/set_light_sprite(l_range, l_power, l_color = NONSENSICAL_VALUE, angle = NONSENSICAL_VALUE, no_update = FALSE,debug = FALSE)

	if(l_range)
		if(!light_sprite)
			light_sprite = new (get_turf(src))
		light_sprite.icon_state = angle == LIGHT_OMNI || angle == NONSENSICAL_VALUE ? "radial" : "cone"
		light_sprite.size = max(1,l_range*(TILE_SIZE/96))
		light_sprite.owner = src
		light_sprite.power = l_power
		if(l_color != NONSENSICAL_VALUE)
			light_sprite.color = l_color
		light_sprite.update_sprite()

	if(!l_range && light_sprite)
		qdel(light_sprite)
		light_sprite = null

	return TRUE

/atom/movable/set_dir(var/desired_dir,var/force = FALSE)

	. = ..()

	if(.)
		for(var/k in light_sprite_sources)
			var/obj/light_sprite/LS = k
			if(LS == src)
				continue
			LS.set_dir(desired_dir,force)

/atom/movable/New(var/desired_loc)
	light_sprite_sources = list()
	. = ..()

/atom/movable/proc/update_collisions(var/normal,var/bullet,var/c_dir,var/force = FALSE)

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

/atom/movable/Finalize()

	set_anchored(anchored,TRUE)

	. = ..()

	if(is_turf(src.loc))

		var/turf/T = src.loc

		if(enable_chunk_handling && SSchunk.initialized)
			var/chunk/C = CHUNK(T)
			src.on_chunk_cross(null,C)

		if((opacity || density))
			if(opacity)
				T.has_opaque_atom = TRUE
			if(density && !abstract)
				T.has_dense_atom = "/atom/movable/Finalize() [src.type]"

	update_value()

/atom/movable/proc/update_value()
	value = get_base_value()
	return TRUE

/proc/is_valid_dir(var/direction)

	/*
	if(!direction || (direction & EAST && direction & WEST) || (direction & NORTH && direction & SOUTH))
		return FALSE
	*/

	if(direction - (NORTH + EAST + SOUTH + WEST) > 0)
		return FALSE

	return TRUE

/atom/movable/get_debug_name()

	var/shown_x = src.x
	var/shown_y = src.y
	var/shown_z = src.z

	if(!src.z)
		var/turf/T = get_turf(src)
		if(T)
			shown_x = T.x
			shown_y = T.y
			shown_z = T.z

	return "[src.name]([src.type])<a href='?spectate=1;x=[shown_x];y=[shown_y];z=[shown_z]'>([shown_x],[shown_y],[shown_z])</a>"


/atom/movable/proc/set_anchored(var/desired_anchored=TRUE,var/force=FALSE)

	if(anchored == desired_anchored && !force)
		return FALSE

	anchored = desired_anchored

	return TRUE


/atom/movable/proc/on_chunk_clean() //What happens if this object is chunk cleaned.
	return FALSE


/atom/movable/proc/dust(var/atom/source)
	return FALSE

/atom/movable/proc/gib(var/gib_direction=0x0,var/hard=FALSE)
	qdel(src)
	return TRUE

/atom/movable/proc/is_safe_to_delete(var/check_loc = TRUE)

	if(check_loc && loc && !src.z) //This means we're in something that isn't a turf.
		return FALSE

	if(is_player_controlled())
		return FALSE

	for(var/k in contents)
		var/atom/movable/A = k
		if(!A.is_safe_to_delete(FALSE))
			return FALSE

	return TRUE

/atom/movable/set_density(var/desired_density=TRUE,var/force=FALSE)

	. = ..()

	if(. && is_turf(loc))
		var/turf/T = loc
		if(T.density != density)
			T.recalculate_atom_density()

	return TRUE