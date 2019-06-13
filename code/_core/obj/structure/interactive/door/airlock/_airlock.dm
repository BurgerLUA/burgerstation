obj/structure/interactive/door/airlock
	name = "airlock"
	desc = "a powered airlock"
	icon = 'icons/obj/structure/future/airlock.dmi'
	icon_state = "closed"
	var/filler = "glass"

	var/base_color = "#FFFFFF"
	var/fill_color = "#FFFFFF"

	open_time = 5
	close_time = 5

obj/structure/interactive/door/airlock/New()
	..()
	update_icon()

obj/structure/interactive/door/airlock/update_icon()

	icon = initial(icon)

	switch(door_state)
		if(DOOR_STATE_OPENING)
			icon_state = "opening"
			desc = "The door is opening."
			opacity = 0
			collision_flags = FLAG_COLLISION_REAL

		if(DOOR_STATE_CLOSING)
			icon_state = "closing"
			desc = "The door is closing."
			opacity = 0
			collision_flags = FLAG_COLLISION_REAL

		if(DOOR_STATE_OPEN)
			icon_state = "open"
			desc = "The door is open."
			opacity = 0
			collision_flags = FLAG_COLLISION_NONE

		if(DOOR_STATE_CLOSED)
			icon_state = "closed"
			desc = "The door is closed."
			opacity = 1
			collision_flags = FLAG_COLLISION_REAL

	var/icon/base_icon = new /icon(icon,icon_state)
	base_icon.Blend(base_color,ICON_MULTIPLY)

	if(filler)
		var/icon/fill_icon = new /icon(icon,"[filler]_[icon_state]")
		fill_icon.Blend(fill_color,ICON_MULTIPLY)
		base_icon.Blend(fill_icon,ICON_OVERLAY)

	if(door_state == DOOR_STATE_OPENING || door_state == DOOR_STATE_CLOSING)
		var/icon/light_icon = new /icon(icon,"lights_[icon_state]")
		base_icon.Blend(light_icon,ICON_OVERLAY)

	icon = base_icon

obj/structure/interactive/door/airlock/Cross(var/atom/movable/A)

	. = ..()

	if(!. && door_state == DOOR_STATE_CLOSED)
		open()

	return .