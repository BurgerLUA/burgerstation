/obj/structure/interactive/door/airlock
	name = "airlock"
	desc = "a powered airlock"
	icon = 'icons/obj/structure/airlock/new_airlock.dmi'
	icon_state = "closed"
	var/filler = "fill"

	var/base_color = "#FFFFFF"
	var/fill_color = "#FFFFFF"

	var/open_wait_time = 3
	var/open_time_01 = 8
	var/open_time_02 = 8

	var/close_time_01 = 8
	var/close_time_02 = 8

	var/opened_time = 0

	open_sound = 'sounds/machines/airlock/open.ogg'
	close_sound = 'sounds/machines/airlock/close.ogg'

	blocks_air = NORTH | EAST | SOUTH | WEST

	var/no_access = FALSE

/obj/structure/interactive/door/airlock/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	if(door_state == DOOR_STATE_CLOSED)
		if(locked)
			open(TRUE)
		else
			lock()
	else if(door_state == DOOR_STATE_OPENED)
		close(TRUE)

	return TRUE

/obj/structure/interactive/door/airlock/think()

	if(door_state == DOOR_STATE_OPENED)
		opened_time += 1
	else if (door_state == DOOR_STATE_CLOSED)
		opened_time = 0

	if(door_state == DOOR_STATE_OPENED && opened_time >= 100)

		var/has_living = FALSE
		for(var/mob/living/L in loc.contents)
			has_living = TRUE
			break

		if(!has_living)
			close()
			return TRUE

		opened_time = 0

	return TRUE

obj/structure/interactive/door/airlock/open(var/lock = FALSE, var/force = FALSE)

	if(!force)
		if(locked)
			return FALSE

		if(door_state != DOOR_STATE_CLOSED || door_state == DOOR_STATE_DENY)
			return FALSE

	set_door_state(DOOR_STATE_START_OPENING,lock)
	return TRUE

obj/structure/interactive/door/airlock/close(var/lock = FALSE, var/force = FALSE)

	if(!force)
		if(locked)
			return FALSE

		if(door_state != DOOR_STATE_OPENED || door_state == DOOR_STATE_DENY)
			return FALSE

	set_door_state(DOOR_STATE_CLOSING_01,lock)
	return TRUE

/obj/structure/interactive/door/proc/set_door_state(var/desired_door_state,var/should_lock=FALSE)
	return TRUE

/obj/structure/interactive/door/airlock/set_door_state(var/desired_door_state,var/should_lock=FALSE)

	door_state = desired_door_state
	update_sprite()

	switch(desired_door_state)
		if(DOOR_STATE_START_OPENING)
			CALLBACK("door_state_\ref[src]",open_wait_time,src,.proc/set_door_state,DOOR_STATE_OPENING_01,should_lock)
			if(open_sound)
				play(open_sound,src)

		if(DOOR_STATE_OPENING_01)
			CALLBACK("door_state_\ref[src]",open_time_01,src,.proc/set_door_state,DOOR_STATE_OPENING_02,should_lock)

		if(DOOR_STATE_OPENING_02)
			CALLBACK("door_state_\ref[src]",open_time_02,src,.proc/set_door_state,DOOR_STATE_OPENED,should_lock)

		if(DOOR_STATE_CLOSING_01)
			CALLBACK("door_state_\ref[src]",close_time_01,src,.proc/set_door_state,DOOR_STATE_CLOSING_02,should_lock)
			if(close_sound)
				play(close_sound,src)

		if(DOOR_STATE_CLOSING_02)
			var/found_living = FALSE
			for(var/mob/living/L in loc.contents)
				if(L)
					found_living = TRUE
					break
			if(found_living)
				set_door_state(DOOR_STATE_OPENING_02,FALSE)
			else
				CALLBACK("door_state_\ref[src]",close_time_02,src,.proc/set_door_state,DOOR_STATE_CLOSED,should_lock)

		if(DOOR_STATE_OPENED)
			world.log << "We're open now. Start thinking. Lock?: [should_lock]."
			opened_time = 0
			start_thinking(src)
			if(should_lock)
				lock()

		if(DOOR_STATE_CLOSED)
			world.log << "We're closed now. Stop thinking."
			stop_thinking(src)
			if(should_lock)
				lock()

	return TRUE





/obj/structure/interactive/door/airlock/update_icon()

	if(color && color != "#FFFFFF")
		base_color = color
		color = "#FFFFFF"

	icon = initial(icon)

	switch(door_state)
		if(DOOR_STATE_OPENING_01)
			icon_state = "opening_01"
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE,a_dir = 0x0)

		if(DOOR_STATE_OPENING_02)
			icon_state = "opening_02"
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE,a_dir = 0x0)
			set_opacity(0)

		if(DOOR_STATE_CLOSING_01)
			icon_state = "closing_01"
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE,a_dir = 0x0)
			set_opacity(0)

		if(DOOR_STATE_CLOSING_02)
			icon_state = "closing_02"
			switch(filler)
				if("glass")
					update_collisions(FLAG_COLLISION_REAL,FLAG_COLLISION_BULLET_SOLID,a_dir = 0x0)
					set_opacity(0)
				else
					update_collisions(FLAG_COLLISION_REAL,FLAG_COLLISION_BULLET_INORGANIC,a_dir = 0x0)
					set_opacity(1)

		if(DOOR_STATE_OPENED)
			icon_state = "open"
			desc = "The door is open."
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE,a_dir = 0x0)
			set_opacity(0)

		if(DOOR_STATE_CLOSED)
			icon_state = "closed"
			desc = "The door is closed."
			switch(filler)
				if("glass")
					update_collisions(FLAG_COLLISION_REAL,FLAG_COLLISION_BULLET_SOLID,a_dir = initial(blocks_air))
					set_opacity(0)
				else
					update_collisions(FLAG_COLLISION_REAL,FLAG_COLLISION_BULLET_INORGANIC,a_dir = initial(blocks_air))
					set_opacity(1)

		if(DOOR_STATE_START_OPENING)
			icon_state = "closed"
			desc = "The door is closed."
			collision_flags = FLAG_COLLISION_REAL
			switch(filler)
				if("glass")
					update_collisions(FLAG_COLLISION_REAL,FLAG_COLLISION_BULLET_SOLID,a_dir = 0x0)
					set_opacity(0)
				else
					update_collisions(FLAG_COLLISION_REAL,FLAG_COLLISION_BULLET_INORGANIC,a_dir = 0x0)
					set_opacity(1)

	var/icon/base_icon = new /icon(icon,icon_state)
	base_icon.Blend(base_color,ICON_MULTIPLY)

	if(filler)
		var/icon/fill_icon = new /icon(icon,"[icon_state]_[filler]")
		fill_icon.Blend(fill_color,ICON_MULTIPLY)
		base_icon.Blend(fill_icon,ICON_OVERLAY)

	var/icon/panel_icon = new /icon(icon,"[icon_state]_panel")
	base_icon.Blend(panel_icon,ICON_OVERLAY)

	var/desired_color = "#FFFFFF"
	if(locked && door_state == DOOR_STATE_CLOSED)
		desired_color = "#FF0000"
	else
		switch(door_state)
			if(DOOR_STATE_OPENING_01,DOOR_STATE_OPENING_02,DOOR_STATE_START_OPENING)
				desired_color = "#00FF00"
			if(DOOR_STATE_CLOSING_01,DOOR_STATE_CLOSING_02)
				desired_color = "#FFFF00"
			if(DOOR_STATE_DENY)
				desired_color = "#FF0000"

	var/light_state = "[icon_state]_light"

	if(door_state == DOOR_STATE_START_OPENING || door_state == DOOR_STATE_DENY || locked && door_state == DOOR_STATE_CLOSED )
		light_state = "light_special_static"

	if(desired_color == "#FFFFFF")
		set_light(FALSE)
	else
		set_light(1,0.75,desired_color)

	var/icon/light_icon = new /icon(icon,light_state)
	light_icon.Blend(desired_color,ICON_MULTIPLY)
	base_icon.Blend(light_icon,ICON_OVERLAY)

	var/icon/frame_icon = new /icon(icon,"frame")
	base_icon.Blend(frame_icon,ICON_OVERLAY)

	icon = base_icon


/obj/structure/interactive/door/airlock/Cross(var/atom/movable/A,var/atom/NewLoc,var/atom/OldLoc)

	. = ..()

	if(!. && door_state == DOOR_STATE_CLOSED)
		open()

	return .

/obj/structure/interactive/door/airlock/glass
	filler = "glass"

/obj/structure/interactive/door/airlock/glass/locked
	locked = TRUE

/obj/structure/interactive/door/airlock/glass/no_manual_close
	allow_manual_close = FALSE

/obj/structure/interactive/door/airlock/glass/no_access
	no_access = TRUE
