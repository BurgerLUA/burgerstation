/obj/structure/interactive/door/airlock
	name = "airlock"
	desc = "a powered airlock"
	icon = 'icons/obj/structure/airlock/new_airlock.dmi'
	icon_state = "closed"

	layer = LAYER_WALL
	plane = PLANE_WALL

	var/filler = "fill"
	var/panel = TRUE

	var/fill_color = "#FFFFFF"

	var/open_wait_time = 3
	var/open_time_01 = 5.5
	var/open_time_02 = 5.5

	var/close_time_01 = 8
	var/close_time_02 = 8

	var/opened_time = 0

	open_sound = 'sound/machines/airlock/open.ogg'
	close_sound = 'sound/machines/airlock/close.ogg'
	deny_sound = 'sound/machines/airlock/deny.ogg'

	var/no_access = FALSE

	var/debug = FALSE

	var/safeties = TRUE

	health = /health/construction/

	health_base = 500

	apc_powered = TRUE

	corner_category = "wall"

/obj/structure/interactive/door/airlock/locked
	locked = TRUE

/obj/structure/interactive/door/airlock/on_destruction(var/damage = TRUE)

	if(door_state != DOOR_STATE_BROKEN)
		set_door_state(null,DOOR_STATE_BROKEN,TRUE)
		health.restore()
		return ..()

	. = ..()

	qdel(src)

/obj/structure/interactive/door/airlock/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	if(door_state == DOOR_STATE_BROKEN)
		return FALSE

	if(door_state == DOOR_STATE_CLOSED)
		if(locked)
			unlock(caller)
			open(caller)
		else
			lock(caller)
	else if(door_state == DOOR_STATE_OPENED)
		close(caller,TRUE)

	return TRUE

/obj/structure/interactive/door/airlock/think()

	if(door_state == DOOR_STATE_BROKEN)
		return FALSE

	if(!loc)
		return FALSE

	if(door_state == DOOR_STATE_OPENED)
		opened_time += 1
	else if (door_state == DOOR_STATE_CLOSED)
		opened_time = 0

	if(door_state == DOOR_STATE_OPENED && opened_time >= 100)
		var/has_living = FALSE
		if(safeties)
			for(var/mob/living/L in loc.contents)
				has_living = TRUE
				break
		if(!has_living)
			close()
			return TRUE

		opened_time = 0

	return TRUE

/obj/structure/interactive/door/airlock/should_smooth_with(var/turf/T)

	. = ..()

	if(. && istype(.,/obj/structure/interactive/door/airlock/))
		return null

obj/structure/interactive/door/airlock/open(var/mob/caller,var/lock = FALSE,var/force = FALSE)

	if(door_state == DOOR_STATE_BROKEN)
		return FALSE

	if(!force)
		if(locked || no_access)
			set_door_state(caller,DOOR_STATE_DENY)
			return FALSE

		if(door_state != DOOR_STATE_CLOSED)
			return FALSE

	if(door_state == DOOR_STATE_OPENED)
		if(!locked && lock)
			lock(caller)
		return FALSE

	set_door_state(caller,DOOR_STATE_START_OPENING,lock)
	return TRUE

obj/structure/interactive/door/airlock/close(var/mob/caller,var/lock = FALSE,var/force = FALSE)

	if(door_state == DOOR_STATE_BROKEN)
		return FALSE

	if(!force)
		if(locked)
			return FALSE

		if(door_state != DOOR_STATE_OPENED)
			return FALSE

	if(door_state == DOOR_STATE_CLOSED)
		if(!locked && lock)
			lock(caller)
		return FALSE

	set_door_state(caller,DOOR_STATE_CLOSING_01,lock)
	return TRUE

/obj/structure/interactive/door/airlock/proc/set_door_state(var/mob/caller=null,var/desired_door_state,var/should_lock=FALSE)

	. = FALSE

	switch(desired_door_state)
		if(DOOR_STATE_BROKEN)
			. = TRUE
		if(DOOR_STATE_DENY)
			CALLBACK("door_state_closed_\ref[src]",6,src,src::set_door_state(),caller,DOOR_STATE_CLOSED,should_lock)
			if(deny_sound)
				play_sound(deny_sound, src.loc,range_max=VIEW_RANGE)
				if(caller) create_alert(VIEW_RANGE,src.loc,caller,ALERT_LEVEL_NOISE)
			. = TRUE

		if(DOOR_STATE_START_OPENING)
			CALLBACK("door_state_opening_01_\ref[src]",open_wait_time,src,src::set_door_state(),caller,DOOR_STATE_OPENING_01,should_lock)
			if(open_sound)
				play_sound(open_sound, src.loc,range_max=VIEW_RANGE)
				if(caller) create_alert(VIEW_RANGE,src.loc,caller,ALERT_LEVEL_NOISE)
			. = TRUE

		if(DOOR_STATE_OPENING_01)
			CALLBACK("door_state_opening_02_\ref[src]",open_time_01,src,src::set_door_state(),caller,DOOR_STATE_OPENING_02,should_lock)
			. = TRUE

		if(DOOR_STATE_OPENING_02)
			CALLBACK("door_state_opened_\ref[src]",open_time_02,src,src::set_door_state(),caller,DOOR_STATE_OPENED,should_lock)
			. = TRUE

		if(DOOR_STATE_CLOSING_01)
			CALLBACK("door_state_closing_02_\ref[src]",close_time_01,src,src::set_door_state(),caller,DOOR_STATE_CLOSING_02,should_lock)
			if(close_sound)
				play_sound(close_sound, src.loc,range_max=VIEW_RANGE)
				if(caller) create_alert(VIEW_RANGE,src.loc,caller,ALERT_LEVEL_NOISE)
			. = TRUE

		if(DOOR_STATE_CLOSING_02)
			var/has_living = FALSE
			for(var/mob/living/L in loc.contents)
				if(safeties)
					has_living = TRUE
					break
				else
					for(var/d in DIRECTIONS_ALL)
						if(L.Move(get_step(L,d)))
							break
			if(has_living)
				set_door_state(has_living,DOOR_STATE_OPENING_02,FALSE)
			else
				CALLBACK("door_state_closed_\ref[src]",close_time_02,src,src::set_door_state(),caller,DOOR_STATE_CLOSED,should_lock)
			. = TRUE

		if(DOOR_STATE_OPENED)
			if(should_lock)
				lock(caller)
			opened_time = 0
			START_THINKING(src)
			. = TRUE

		if(DOOR_STATE_CLOSED)
			STOP_THINKING(src)
			if(should_lock)
				lock(caller)
			. = TRUE

	if(.)
		door_state = desired_door_state
		update_sprite()
	else
		log_error("ERROR: [src.get_debug_name()] did not have a proper set_door_state call when trying to set the state to [desired_door_state]!")

	return .


/obj/structure/interactive/door/airlock/update_sprite()

	icon = initial(icon)
	underlays.Cut()
	overlays.Cut()

	var/light_state = null
	var/light_color = null

	switch(door_state)
		if(DOOR_STATE_OPENING_01)
			icon_state = "opening_01"
			light_state = "opening_01_light"
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE)
			light_color = "#FFFF00"

		if(DOOR_STATE_OPENING_02)
			icon_state = "opening_02"
			light_state = "opening_02_light"
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE)
			light_color = "#00FF00"
			set_opacity(0)

		if(DOOR_STATE_CLOSING_01)
			icon_state = "closing_01"
			light_state = "closing_01_light"
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE)
			light_color = "#FFFF00"
			set_opacity(0)

		if(DOOR_STATE_CLOSING_02)
			icon_state = "closing_02"
			light_state = "closing_02_light"
			switch(filler)
				if("glass")
					update_collisions(FLAG_COLLISION_WALL,FLAG_COLLISION_BULLET_WINDOW)
					set_opacity(0)
				else
					update_collisions(FLAG_COLLISION_WALL,FLAG_COLLISION_BULLET_INORGANIC)
					set_opacity(1)
			light_color = "#FF0000"

		if(DOOR_STATE_OPENED)
			icon_state = "open"
			light_state = "open_light"
			light_color = null
			desc = "The door is open."
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE)
			set_opacity(0)

		if(DOOR_STATE_CLOSED)
			icon_state = "closed"
			light_state = "closed_light"
			light_color = null
			desc = "The door is closed."
			switch(filler)
				if("glass")
					update_collisions(FLAG_COLLISION_WALL,FLAG_COLLISION_BULLET_SOLID)
					set_opacity(0)
				else
					update_collisions(FLAG_COLLISION_WALL,FLAG_COLLISION_BULLET_INORGANIC)
					set_opacity(1)
			if(locked)
				light_state = "light_special_static"
				light_color = "#FF0000"

		if(DOOR_STATE_DENY)
			light_state = "light_special_access"
			light_color = "#FF0000"

		if(DOOR_STATE_START_OPENING)
			light_state = "light_special_static"
			light_color = "#00FF00"

		if(DOOR_STATE_BROKEN)
			icon_state = "broken"
			light_state = "broken_light"
			light_color = "#FF0000"
			desc = "The door is broken."
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE)
			set_opacity(0)

	if(filler)
		var/image/fill = new/image(icon,"[icon_state]_[filler]")
		fill.appearance_flags = src.appearance_flags | RESET_COLOR
		fill.color = fill_color
		if(filler == "glass")
			fill.alpha = 150
		underlays += fill

	if(panel)
		var/image/panel = new /image(icon,"[icon_state]_panel")
		panel.appearance_flags = src.appearance_flags | RESET_COLOR
		add_overlay(panel)

	if(powered && light_state)
		var/image/light_fixtures = new /image(icon,light_state)
		light_fixtures.appearance_flags = src.appearance_flags | RESET_COLOR
		light_fixtures.color = light_color ? light_color : "#FFFFFF"
		add_overlay(light_fixtures)

	if(anchored)
		var/image/frame = new/image(icon,"frame")
		frame.appearance_flags = src.appearance_flags | RESET_COLOR
		add_underlay(frame)

		for(var/d in DIRECTIONS_CARDINAL)
			var/turf/T = get_step(src,d)
			if(!T)
				continue
			var/atom/A = src.should_smooth_with(T)
			if(A )
				var/image/I = new/image(icon,"metal_frame_[d]")
				if(A == T)
					I.color = A.color
				else
					I.color = COLOR_STEEL
				I.appearance_flags = src.appearance_flags | RESET_COLOR | RESET_ALPHA | KEEP_APART
				add_overlay(I)

/obj/structure/interactive/door/airlock/Cross(atom/movable/O,atom/oldloc)

	. = ..()

	if(!. && is_living(O) && door_state == DOOR_STATE_CLOSED && door_state != DOOR_STATE_DENY)
		var/mob/living/L = O
		if(!L.dead)
			open(L)


/obj/structure/interactive/door/airlock/glass
	filler = "glass"

/obj/structure/interactive/door/airlock/glass/locked
	locked = TRUE

/obj/structure/interactive/door/airlock/glass/no_manual_close
	allow_manual_close = FALSE

/obj/structure/interactive/door/airlock/glass/no_access
	no_access = TRUE
