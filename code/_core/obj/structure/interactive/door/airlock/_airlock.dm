/obj/structure/interactive/door/airlock
	name = "airlock"
	desc = "a powered airlock"
	icon = 'icons/obj/structure/airlock/airlock.dmi'
	icon_state = "closed"
	var/filler = "fill"

	var/base_color = "#FFFFFF"
	var/fill_color = "#FFFFFF"

	open_time = 8
	close_time = 5

	thinks = TRUE

	var/opened_time = 0

	open_sound = 'sounds/machines/airlock/open.ogg'
	close_sound = 'sounds/machines/airlock/close.ogg'

/obj/structure/interactive/door/airlock/think()

	if(door_state == DOOR_STATE_OPENED)
		opened_time += 1
	else
		opened_time = 0

	if(door_state == DOOR_STATE_OPENED && opened_time >= 100)

		var/has_living = FALSE
		for(var/mob/living/L in contents)
			has_living = TRUE
			break

		if(!has_living)
			close()
			return FALSE

		opened_time = 0

	return TRUE

obj/structure/interactive/door/airlock/open()
	. = ..()
	if(thinks)
		all_thinkers += src
	return .

/obj/structure/interactive/door/airlock/update_icon()

	icon = initial(icon)

	switch(door_state)
		if(DOOR_STATE_OPENING)
			icon_state = "opening"
			desc = "The door is opening."

			//Start from closed
			collision_flags = FLAG_COLLISION_REAL
			switch(filler)
				if("glass")
					set_opacity(0)
					collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
				else
					collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
					set_opacity(1)

			//Then open
			spawn(open_time*0.5)
				set_opacity(0)
				collision_flags = FLAG_COLLISION_NONE
				collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

		if(DOOR_STATE_CLOSING)
			icon_state = "closing"
			desc = "The door is closing."

			//Start from open
			set_opacity(0)
			collision_flags = FLAG_COLLISION_NONE
			collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

			//Then close
			spawn(close_time*0.25)
				collision_flags = FLAG_COLLISION_REAL
				switch(filler)
					if("glass")
						set_opacity(0)
						collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
					else
						collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
						set_opacity(1)

		if(DOOR_STATE_OPENED)
			icon_state = "open"
			desc = "The door is open."
			set_opacity(0)
			collision_flags = FLAG_COLLISION_NONE
			collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

		if(DOOR_STATE_CLOSED)
			icon_state = "closed"
			desc = "The door is closed."
			collision_flags = FLAG_COLLISION_REAL
			switch(filler)
				if("glass")
					set_opacity(0)
					collision_bullet_flags = FLAG_COLLISION_BULLET_SOLID
				else
					collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
					set_opacity(1)

	var/icon/base_icon = new /icon(icon,icon_state)
	base_icon.Blend(base_color,ICON_MULTIPLY)

	if(filler)
		var/icon/fill_icon = new /icon(icon,"[filler]_[icon_state]")
		fill_icon.Blend(fill_color,ICON_MULTIPLY)
		base_icon.Blend(fill_icon,ICON_OVERLAY)

	if(locked && door_state == DOOR_STATE_CLOSED)
		var/icon/light_icon = new /icon(icon,"lights_bolts")
		base_icon.Blend(light_icon,ICON_OVERLAY)

	if(door_state == DOOR_STATE_OPENING || door_state == DOOR_STATE_CLOSING)
		var/icon/light_icon = new /icon(icon,"lights_[icon_state]")
		base_icon.Blend(light_icon,ICON_OVERLAY)

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

