/atom/movable/

	step_size = TILE_SIZE

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	animate_movement = SLIDE_STEPS

	var/area/area //The object's area.

	var/tmp/move_dir = 0x0
	var/tmp/move_dir_last = 0x0 //Used for momentum and speed.
	var/tmp/first_move_dir = 0x0 //The first movement key pressed. Only used for mobs.
	var/tmp/move_delay = 0

	var/size = SIZE_0

	var/movement_delay = 4 //Measured in ticks.
	var/anchored = TRUE
	var/ghost = FALSE

	var/damage_type_thrown //Damage type if the object is thrown. If none is provided, it will just use damage_type and double the damage.

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

	var/value_last = 0//Last value calculated via calculation

	var/is_moving = TRUE

	var/obj/light_sprite/light_sprite
	var/list/obj/light_sprite/light_sprite_sources //Doesn't need to be qdeled

/atom/movable/proc/set_light_sprite(l_range, l_power, l_color = NONSENSICAL_VALUE, angle = NONSENSICAL_VALUE, no_update = FALSE,debug = FALSE)

	if(l_range)
		if(!light_sprite)
			light_sprite = new (get_turf(src))
		light_sprite.icon_state = angle == LIGHT_OMNI || angle == NONSENSICAL_VALUE ? "radial" : "cone"
		light_sprite.size = max(1,l_range*(TILE_SIZE/96))
		light_sprite.owner = src
		light_sprite.alpha = l_power*255
		if(l_color != NONSENSICAL_VALUE)
			light_sprite.color = l_color
		light_sprite.update_sprite()

	if(!l_range && light_sprite)
		qdel(light_sprite)
		light_sprite = null

	return TRUE

/atom/movable/set_dir(var/desired_dir,var/force = FALSE)

	. = ..()

	if(isturf(src.loc))
		for(var/k in light_sprite_sources)
			var/obj/light_sprite/LS = k
			LS.set_dir(desired_dir,force)

	return .

/atom/movable/post_move(var/atom/old_loc)

	. = ..()

	if(isturf(src.loc))
		for(var/k in light_sprite_sources)
			var/obj/light_sprite/LS = k
			LS.force_move(src.loc)

	return .


/atom/movable/New(var/desired_loc)
	light_sprite_sources = list()
	return ..()

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

/atom/movable/Finalize()
	value = get_base_value()
	return ..()


/atom/movable/Destroy()
	QDEL_NULL(light_sprite)

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


/atom/movable/proc/set_anchored(var/desired_anchored=TRUE)

	if(anchored == desired_anchored)
		return FALSE

	anchored = desired_anchored

	if(!anchored)
		force_move(loc)

	return TRUE