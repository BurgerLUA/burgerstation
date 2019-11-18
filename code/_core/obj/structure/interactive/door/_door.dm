#define DOOR_STATE_OPENED 1
#define DOOR_STATE_OPENING_01 2
#define DOOR_STATE_OPENING_02 3
#define DOOR_STATE_CLOSED 4
#define DOOR_STATE_CLOSING_01 5
#define DOOR_STATE_CLOSING_02 6
#define DOOR_STATE_LOCKED 7 //Only used for singleplayer airlocks
#define DOOR_STATE_START_OPENING 8 //Only used for airlocks
#define DOOR_STATE_DENY 9 //Only used for airlocks


obj/structure/interactive/door
	name = "door"
	desc = "What's on the other side?"
	collision_flags = FLAG_COLLISION_REAL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	opacity = 1
	icon = 'icons/obj/structure/airlock/doors.dmi'
	icon_state = "woodrustic"

	var/door_state = DOOR_STATE_CLOSED

	var/open_time = 10
	var/close_time = 10

	var/locked = FALSE
	var/allow_manual_open = TRUE
	var/allow_manual_close = TRUE

	var/open_sound = null
	var/close_sound = null

obj/structure/interactive/door/New()
	. = ..()
	update_icon()
	return .

obj/structure/interactive/door/update_icon()
	..()
	switch(door_state)
		if(DOOR_STATE_OPENING_01)
			icon_state = "[initial(icon_state)]opening"
			desc = "The door is opening."
			set_opacity(0)
			collision_flags = FLAG_COLLISION_REAL
			collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

		if(DOOR_STATE_CLOSING_01)
			icon_state = "[initial(icon_state)]closing"
			desc = "The door is closing."
			set_opacity(0)
			collision_flags = FLAG_COLLISION_NONE
			collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

		if(DOOR_STATE_OPENED)
			icon_state = "[initial(icon_state)]open"
			desc = "The door is open."
			set_opacity(0)
			collision_flags = FLAG_COLLISION_NONE
			collision_bullet_flags = FLAG_COLLISION_BULLET_NONE

		if(DOOR_STATE_CLOSED)
			icon_state = initial(icon_state)
			desc = "The door is closed."
			set_opacity(initial(opacity))
			collision_flags = FLAG_COLLISION_REAL
			collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC


obj/structure/interactive/door/proc/open()
	if(open_sound)
		play(open_sound)
	door_state = DOOR_STATE_OPENING_01
	update_icon()
	spawn(open_time)
		door_state = DOOR_STATE_OPENED
		update_icon()


obj/structure/interactive/door/proc/close()
	if(close_sound)
		play(close_sound)
	door_state = DOOR_STATE_CLOSING_01
	update_icon()
	spawn(close_time)
		door_state = DOOR_STATE_CLOSED
		update_icon()




obj/structure/interactive/door/clicked_on_by_object(caller,object,location,control,params)

	INTERACT_CHECK

	if(!is_mob(caller))
		return FALSE

	if(door_state == DOOR_STATE_OPENED && allow_manual_close)
		close()
	else if(door_state == DOOR_STATE_CLOSED && allow_manual_open)
		open()

	return TRUE

obj/structure/interactive/door/wood
	name = "wooden door"

obj/structure/interactive/door/metal
	name = "iron door"
	icon_state = "silver"
	color = "#888888"