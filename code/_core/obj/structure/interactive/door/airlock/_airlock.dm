/obj/structure/interactive/door/airlock
	name = "airlock"
	desc = "a powered airlock"
	icon = 'icons/obj/structure/airlock/new_airlock.dmi'
	icon_state = "closed"

	var/filler = "fill"
	var/panel = TRUE

	var/fill_color = "#FFFFFF"

	var/open_wait_time = 3
	var/open_time_01 = 8
	var/open_time_02 = 8

	var/close_time_01 = 8
	var/close_time_02 = 8

	var/opened_time = 0

	open_sound = 'sound/machines/airlock/open.ogg'
	close_sound = 'sound/machines/airlock/close.ogg'
	deny_sound = 'sound/machines/airlock/deny.ogg'

	blocks_air = NORTH | EAST | SOUTH | WEST

	var/no_access = FALSE

	var/debug = FALSE

	var/safeties = TRUE

	health = /health/construction/

	health_base = 500

/obj/structure/interactive/door/airlock/locked
	locked = TRUE

/obj/structure/interactive/door/airlock/on_destruction(var/mob/caller,var/damage = FALSE)
	if(door_state == DOOR_STATE_BROKEN)
		set_door_state(caller,DOOR_STATE_BROKEN,TRUE)
		health.restore()
		return ..()
	else
		. = ..()
		qdel(src)
		return .



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
		for(var/mob/living/L in loc.contents)
			if(safeties)
				has_living = TRUE
				break

		if(!has_living)
			close()
			return TRUE

		opened_time = 0

	return TRUE

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

/obj/structure/interactive/door/proc/set_door_state(var/mob/caller=null,var/desired_door_state,var/should_lock=FALSE)
	return TRUE

/obj/structure/interactive/door/airlock/set_door_state(var/mob/caller=null,var/desired_door_state,var/should_lock=FALSE)

	door_state = desired_door_state
	update_sprite()

	switch(desired_door_state)
		if(DOOR_STATE_DENY)
			CALLBACK("door_state_\ref[src]",6,src,.proc/set_door_state,caller,DOOR_STATE_CLOSED,should_lock)
			if(deny_sound)
				play_sound(deny_sound, src.loc,range_max=VIEW_RANGE)
				if(caller) create_alert(VIEW_RANGE,src.loc,caller,ALERT_LEVEL_NOISE)

		if(DOOR_STATE_START_OPENING)
			CALLBACK("door_state_\ref[src]",open_wait_time,src,.proc/set_door_state,caller,DOOR_STATE_OPENING_01,should_lock)
			if(open_sound)
				play_sound(open_sound, src.loc,range_max=VIEW_RANGE)
				if(caller) create_alert(VIEW_RANGE,src.loc,caller,ALERT_LEVEL_NOISE)

		if(DOOR_STATE_OPENING_01)
			CALLBACK("door_state_\ref[src]",open_time_01,src,.proc/set_door_state,caller,DOOR_STATE_OPENING_02,should_lock)

		if(DOOR_STATE_OPENING_02)
			CALLBACK("door_state_\ref[src]",open_time_02,src,.proc/set_door_state,caller,DOOR_STATE_OPENED,should_lock)

		if(DOOR_STATE_CLOSING_01)
			CALLBACK("door_state_\ref[src]",close_time_01,src,.proc/set_door_state,caller,DOOR_STATE_CLOSING_02,should_lock)
			if(close_sound)
				play_sound(close_sound, src.loc,range_max=VIEW_RANGE)
				if(caller) create_alert(VIEW_RANGE,src.loc,caller,ALERT_LEVEL_NOISE)

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
				CALLBACK("door_state_\ref[src]",close_time_02,src,.proc/set_door_state,caller,DOOR_STATE_CLOSED,should_lock)

		if(DOOR_STATE_OPENED)
			if(should_lock)
				lock(caller)
			opened_time = 0
			start_thinking(src)

		if(DOOR_STATE_CLOSED)
			stop_thinking(src)
			if(should_lock)
				lock(caller)

	return TRUE


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
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE,a_dir = 0x0)
			light_color = "#FFFF00"

		if(DOOR_STATE_OPENING_02)
			icon_state = "opening_02"
			light_state = "opening_02_light"
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE,a_dir = 0x0)
			light_color = "#00FF00"
			set_opacity(0)

		if(DOOR_STATE_CLOSING_01)
			icon_state = "closing_01"
			light_state = "closing_01_light"
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE,a_dir = 0x0)
			light_color = "#FFFF00"
			set_opacity(0)

		if(DOOR_STATE_CLOSING_02)
			icon_state = "closing_02"
			light_state = "closing_02_light"
			switch(filler)
				if("glass")
					update_collisions(FLAG_COLLISION_WALL,FLAG_COLLISION_BULLET_SOLID,a_dir = 0x0)
					set_opacity(0)
				else
					update_collisions(FLAG_COLLISION_WALL,FLAG_COLLISION_BULLET_INORGANIC,a_dir = 0x0)
					set_opacity(1)
			light_color = "#FF0000"

		if(DOOR_STATE_OPENED)
			icon_state = "open"
			light_state = "open_light"
			light_color = null
			desc = "The door is open."
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE,a_dir = 0x0)
			set_opacity(0)

		if(DOOR_STATE_CLOSED)
			icon_state = "closed"
			light_state = "closed_light"
			light_color = null
			desc = "The door is closed."
			switch(filler)
				if("glass")
					update_collisions(FLAG_COLLISION_WALL,FLAG_COLLISION_BULLET_SOLID,a_dir = initial(blocks_air))
					set_opacity(0)
				else
					update_collisions(FLAG_COLLISION_WALL,FLAG_COLLISION_BULLET_INORGANIC,a_dir = initial(blocks_air))
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
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE,a_dir = 0x0)
			set_opacity(0)

	if(filler)
		var/image/fill = new/image(icon,"[icon_state]_[filler]")
		fill.appearance_flags = RESET_COLOR
		fill.color = fill_color
		if(filler == "glass")
			fill.alpha = 150
		underlays += fill

	if(panel)
		var/image/panel = new /image(icon,"[icon_state]_panel")
		panel.appearance_flags = RESET_COLOR
		add_overlay(panel)

	if(light_state)
		var/image/light_fixtures = new /image(icon,light_state)
		light_fixtures.appearance_flags = RESET_COLOR
		light_fixtures.color = light_color ? light_color : "#FFFFFF"
		add_overlay(light_fixtures)

	var/image/frame = new /icon(icon,"frame")
	add_overlay(frame)



/obj/structure/interactive/door/airlock/proc/get_light_color()



/obj/structure/interactive/door/airlock/Cross(atom/movable/O)

	. = ..()

	if(!. && is_living(O) && door_state == DOOR_STATE_CLOSED && door_state != DOOR_STATE_DENY)
		var/mob/living/L = O
		if(!L.dead)
			open(L)

	return .

/obj/structure/interactive/door/airlock/glass
	filler = "glass"

/obj/structure/interactive/door/airlock/glass/locked
	locked = TRUE

/obj/structure/interactive/door/airlock/glass/no_manual_close
	allow_manual_close = FALSE

/obj/structure/interactive/door/airlock/glass/no_access
	no_access = TRUE
