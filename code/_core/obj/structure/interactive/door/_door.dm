#define DOOR_STATE_OPEN 1
#define DOOR_STATE_OPENING 2
#define DOOR_STATE_CLOSED 3
#define DOOR_STATE_CLOSING 4


obj/structure/interactive/door
	name = "door"
	desc = "What's on the other side?"
	density = 1
	opacity = 1
	icon = 'icons/obj/structure/medieval/doors.dmi'
	icon_state = "woodrustic"

	var/door_state = DOOR_STATE_CLOSED

obj/structure/interactive/door/New()
	..()
	update_icon()

obj/structure/interactive/door/can_not_enter(A,move_direction)

	if(door_state == DOOR_STATE_CLOSED)
		return src

	return FALSE

obj/structure/interactive/door/update_icon()

	..()

	switch(door_state)
		if(DOOR_STATE_OPENING)
			icon_state = "[initial(icon_state)]opening"
			desc = "The door is opening."
			opacity = 0

		if(DOOR_STATE_CLOSING)
			icon_state = "[initial(icon_state)]closing"
			desc = "The door is closing."
			opacity = 0

		if(DOOR_STATE_OPEN)
			icon_state = "[initial(icon_state)]open"
			desc = "The door is open."
			opacity = 0

		if(DOOR_STATE_CLOSED)
			icon_state = initial(icon_state)
			desc = "The door is closed."
			opacity = 1

obj/structure/interactive/door/clicked_by_object(caller,object,location,control,params)

	INTERACT_CHECK

	if(!is_mob(caller))
		return FALSE

	if(door_state == DOOR_STATE_OPEN)
		door_state = DOOR_STATE_CLOSING
		update_icon()
		spawn(10)
			door_state = DOOR_STATE_CLOSED
			update_icon()
	else if(door_state == DOOR_STATE_CLOSED)
		door_state = DOOR_STATE_OPENING
		update_icon()
		spawn(10)
			door_state = DOOR_STATE_OPEN
			update_icon()

	return TRUE

obj/structure/interactive/door/wood
	name = "wooden door"


obj/structure/interactive/door/metal
	name = "iron door"
	icon_state = "silver"
	color = "#888888"