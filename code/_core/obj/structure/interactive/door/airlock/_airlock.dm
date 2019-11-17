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

	thinks = TRUE

	var/opened_time = 0

	open_sound = 'sounds/machines/airlock/open.ogg'
	close_sound = 'sounds/machines/airlock/close.ogg'

	var/no_access = FALSE

/obj/structure/interactive/door/airlock/think()

	if(door_state == DOOR_STATE_OPENED)
		opened_time += 1
	else if (door_state == DOOR_STATE_CLOSED)
		opened_time = 0

	if(door_state == DOOR_STATE_OPENED && opened_time >= 100)

		var/has_living = FALSE
		for(var/mob/living/L in contents)
			has_living = TRUE
			break

		if(!has_living)
			close()
			return TRUE

		opened_time = 0

	return TRUE

obj/structure/interactive/door/airlock/open()

	if(door_state != DOOR_STATE_CLOSED)
		return FALSE

	if(door_state == DOOR_STATE_DENY)
		return FALSE

	spawn()

		if(no_access)
			door_state = DOOR_STATE_DENY
			update_icon()
			sleep(10)
			door_state = DOOR_STATE_CLOSED
			update_icon()
			return

		if(open_sound)
			play(open_sound)

		door_state = DOOR_STATE_START_OPENING
		update_icon()

		sleep(open_wait_time)

		door_state = DOOR_STATE_OPENING_01
		update_icon()

		sleep(open_time_01)

		door_state = DOOR_STATE_OPENING_02
		update_icon()

		sleep(open_time_02)

		door_state = DOOR_STATE_OPENED
		update_icon()

		if(thinks && !(src in all_thinkers))
			all_thinkers += src

obj/structure/interactive/door/airlock/close()

	if(door_state != DOOR_STATE_OPENED)
		return FALSE

	spawn()

		if(close_sound)
			play(close_sound)

		door_state = DOOR_STATE_CLOSING_01
		update_icon()

		sleep(close_time_01)

		var/found_living = FALSE
		for(var/mob/living/L in loc.contents)
			if(L)
				found_living = TRUE
				break

		if(found_living)
			door_state = DOOR_STATE_OPENING_02
			update_icon()

			sleep(open_time_02)

			door_state = DOOR_STATE_OPENED
			update_icon()

			if(thinks && !(src in all_thinkers))
				all_thinkers += src

		else
			door_state = DOOR_STATE_CLOSING_02
			update_icon()

			sleep(close_time_02)

			door_state = DOOR_STATE_CLOSED
			update_icon()

			if(thinks && !(src in all_thinkers))
				all_thinkers -= src

/obj/structure/interactive/door/airlock/update_icon()

	if(color && color != "#FFFFFF")
		base_color = color
		color = "#FFFFFF"

	icon = initial(icon)

	switch(door_state)


		if(DOOR_STATE_OPENING_01)
			icon_state = "opening_01"
			collision_flags = FLAG_COLLISION_REAL
			switch(filler)
				if("glass")
					collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
					set_opacity(0)
				else
					collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
					set_opacity(1)

		if(DOOR_STATE_OPENING_02)
			icon_state = "opening_02"
			collision_flags = FLAG_COLLISION_NONE
			collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
			set_opacity(0)

		if(DOOR_STATE_CLOSING_01)
			icon_state = "closing_01"
			collision_flags = FLAG_COLLISION_NONE
			collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
			set_opacity(0)

		if(DOOR_STATE_CLOSING_02)
			icon_state = "closing_02"
			collision_flags = FLAG_COLLISION_REAL
			switch(filler)
				if("glass")
					collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
					set_opacity(0)
				else
					collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
					set_opacity(1)

		if(DOOR_STATE_OPENED)
			icon_state = "open"
			desc = "The door is open."
			collision_flags = FLAG_COLLISION_NONE
			collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
			set_opacity(0)

		if(DOOR_STATE_CLOSED)
			icon_state = "closed"
			desc = "The door is closed."
			collision_flags = FLAG_COLLISION_REAL
			switch(filler)
				if("glass")
					collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
					set_opacity(0)
				else
					collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
					set_opacity(1)

		if(DOOR_STATE_START_OPENING)
			icon_state = "closed"
			desc = "The door is closed."
			collision_flags = FLAG_COLLISION_REAL
			switch(filler)
				if("glass")
					collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
					set_opacity(0)
				else
					collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
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
	if(locked)
		desired_color = "#FF0000"
	else
		switch(door_state)
			if(DOOR_STATE_OPENING_01,DOOR_STATE_OPENING_02,DOOR_STATE_START_OPENING)
				desired_color = "#00FF00"
			if(DOOR_STATE_CLOSING_01)
				desired_color = "#FFFF00"
			if(DOOR_STATE_CLOSING_02,DOOR_STATE_DENY)
				desired_color = "#FF0000"

	var/light_state = "[icon_state]_light"

	if(door_state == DOOR_STATE_START_OPENING || door_state == DOOR_STATE_DENY)
		light_state = "light_special_static"

	world.log << light_state

	var/icon/light_icon = new /icon(icon,light_state)
	light_icon.Blend(desired_color,ICON_MULTIPLY)
	base_icon.Blend(light_icon,ICON_OVERLAY)

	var/icon/frame_icon = new /icon(icon,"frame")
	base_icon.Blend(frame_icon,ICON_OVERLAY)

	icon = base_icon


/obj/structure/interactive/door/airlock/Cross(var/atom/movable/A)

	. = ..()

	if(!. && door_state == DOOR_STATE_CLOSED)
		open()

	if(.)
		opened_time = 0

	return .


/obj/structure/interactive/door/airlock/glass
	filler = "glass"

/obj/structure/interactive/door/airlock/glass/locked
	locked = TRUE

/obj/structure/interactive/door/airlock/glass/no_manual_close
	allow_manual_close = FALSE

/obj/structure/interactive/door/airlock/glass/no_access
	no_access = TRUE
