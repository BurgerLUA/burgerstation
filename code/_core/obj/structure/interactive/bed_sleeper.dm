/obj/structure/interactive/bed/sleeper
	name = "sleeper"
	icon_state = "sleeper"
	icon = 'icons/obj/structure/sleeper.dmi'
	icon_state = "sleeper"

	var/door_state = SLEEPER_CLOSED

	var/base_color = "#FFFFFF"
	secondary_color = "#FFFFFF"
	var/tertiary_color = "#FFFFFF"

	var/open_sound
	var/close_sound

	var/open_time = 12
	var/close_time = 12

	pixel_y = 4
	pixel_offset_y = 4
	pixel_offset_x = 8
	layer = LAYER_MOB_ABOVE
	plane = PLANE_EFFECT

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

	collision_dir = NORTH | EAST | SOUTH | WEST

	interaction_flags = FLAG_INTERACTION_LIVING

	density = TRUE

/obj/structure/interactive/bed/sleeper/Initialize()
	new /obj/structure/interactive/blocker(get_step(loc,EAST),src)
	check_collisions()
	set_light(2, 0.25, secondary_color)
	return ..()

/obj/structure/interactive/bed/sleeper/Finalize()
	. = ..()
	icon = initial(icon)
	icon_state = "closed"
	color = secondary_color
	alpha = 175


/obj/structure/interactive/bed/sleeper/update_underlays()
	. = ..()
	var/image/I = new/image(initial(icon),"under")
	I.plane = PLANE_MOVABLE_DEAD
	I.layer = LAYER_MOB_BELOW
	I.color = base_color
	I.appearance_flags = appearance_flags | RESET_COLOR | RESET_ALPHA
	add_underlay(I)
	var/image/I2 = new/image(initial(icon),"padding")
	I2.plane = PLANE_MOVABLE_DEAD
	I2.layer = LAYER_MOB_BELOW
	I2.color = tertiary_color
	I2.appearance_flags = appearance_flags | RESET_COLOR | RESET_ALPHA
	add_underlay(I2)

/obj/structure/interactive/bed/sleeper/update_overlays()
	. = ..()
	var/image/I = new/image(initial(icon),"over")
	I.plane = PLANE_MOVABLE_DEAD
	I.layer = LAYER_MOB_ABOVE
	I.color = base_color
	I.appearance_flags = appearance_flags | RESET_COLOR | RESET_ALPHA
	add_overlay(I)

/obj/structure/interactive/bed/sleeper/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(door_state == SLEEPER_CLOSING || door_state == SLEEPER_OPENING)
		return TRUE

	if(door_state == SLEEPER_CLOSED)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		open(caller)
		return TRUE

	. = ..()

	if(.)
		return TRUE

	if(door_state == SLEEPER_OPENED)
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		close(caller)
		return TRUE

	return FALSE

/obj/structure/interactive/bed/sleeper/buckle(var/mob/living/victim,var/mob/caller,var/silent=FALSE)

	if(door_state != SLEEPER_OPENED)
		return FALSE

	return ..()

/obj/structure/interactive/bed/sleeper/unbuckle(var/mob/caller,var/silent=FALSE)

	if(door_state == SLEEPER_CLOSED)
		open(caller)
		return FALSE
	else if(door_state != SLEEPER_OPENED)
		return FALSE

	return ..()

/obj/structure/interactive/bed/sleeper/proc/open(var/mob/caller)
	if(open_sound)
		play_sound(open_sound,src.loc,range_max=VIEW_RANGE)
	door_state = SLEEPER_OPENING
	flick("opening",src)
	CALLBACK("on_open_\ref[src]",open_time,src,src::on_open(),caller)

/obj/structure/interactive/bed/sleeper/proc/on_open(var/mob/caller)
	door_state = SLEEPER_OPENED
	opened_time = 0
	icon_state = "opened"
	check_collisions()
	START_THINKING(src)
	return TRUE

/obj/structure/interactive/bed/sleeper/proc/on_close(var/mob/caller)
	door_state = SLEEPER_CLOSED
	opened_time = 0
	icon_state = "closed"
	check_collisions()
	return TRUE

/obj/structure/interactive/bed/sleeper/proc/can_buckle(var/mob/living/advanced/A,var/mob/caller)
	return TRUE

/obj/structure/interactive/bed/sleeper/proc/close(var/mob/caller)
	if(!buckled)
		var/mob/living/advanced/A = locate() in get_turf(src)
		if(A && can_buckle(A,caller))
			buckle(A,caller)
	if(close_sound)
		play_sound(close_sound,src.loc,range_max=VIEW_RANGE)
	door_state = SLEEPER_CLOSING
	flick("closing",src)
	CALLBACK("on_close_\ref[src]",close_time,src,src::on_close(),caller)
	STOP_THINKING(src)

/obj/structure/interactive/bed/sleeper/think()

	if(buckled)
		return TRUE

	var/mob/living/L = locate() in loc.contents
	if(L)
		return TRUE

	if(door_state == SLEEPER_OPENED && opened_time >= 100)
		close()
		return FALSE

	opened_time++

	return TRUE

obj/structure/interactive/bed/sleeper/proc/check_collisions()

	var/desired_collision_flags = initial(collision_flags)
	var/desired_collision_bullet_flags = initial(collision_flags)

	if(door_state == SLEEPER_OPENED)
		desired_collision_flags = FLAG_COLLISION_NONE
		desired_collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
		set_light(FALSE)

	update_collisions(desired_collision_flags,desired_collision_bullet_flags)

	return TRUE