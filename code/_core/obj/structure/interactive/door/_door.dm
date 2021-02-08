#define DOOR_STATE_OPENED "opened"
#define DOOR_STATE_OPENING_01 "opening_01"
#define DOOR_STATE_OPENING_02 "opening_02"
#define DOOR_STATE_CLOSED "closed"
#define DOOR_STATE_CLOSING_01 "closing_01"
#define DOOR_STATE_CLOSING_02 "closing_02"
#define DOOR_STATE_LOCKED "locked" //Only used for singleplayer airlocks
#define DOOR_STATE_START_OPENING "start_opening" //Only used for airlocks
#define DOOR_STATE_DENY "deny" //Only used for airlocks
#define DOOR_STATE_BROKEN "broken"


obj/structure/interactive/door
	name = "door"
	desc = "What's on the other side?"
	collision_flags = FLAG_COLLISION_WALL
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
	var/deny_sound = null

	var/spawn_signaller = FALSE
	var/radio_frequency = RADIO_FREQ_DOOR
	var/radio_signal = 20

	layer = LAYER_OBJ_DOOR_CLOSED

	plane = PLANE_WALL

	density = TRUE

/obj/structure/interactive/door/New(var/desired_loc)

	if(spawn_signaller)
		var/obj/item/device/signaller/S = new(src)
		S.name = "[name] [S.name]"
		S.frequency_current = radio_frequency
		S.signal_current = radio_signal
		INITIALIZE(S)
		GENERATE(S)
		FINALIZE(S)
		door_state = DOOR_STATE_CLOSED
		locked = TRUE

	return ..()

/obj/structure/interactive/door/PostInitialize()
	. = ..()
	update_sprite()
	return .

obj/structure/interactive/door/update_icon()
	..()
	switch(door_state)
		if(DOOR_STATE_OPENING_01)
			icon_state = "[initial(icon_state)]opening"
			desc = "The door is opening."
			update_collisions(FLAG_COLLISION_WALL,FLAG_COLLISION_BULLET_INORGANIC)
			layer = LAYER_OBJ_DOOR_CLOSED
			set_opacity(0)

		if(DOOR_STATE_CLOSING_01)
			icon_state = "[initial(icon_state)]closing"
			desc = "The door is closing."
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE)
			layer = LAYER_OBJ_DOOR_CLOSED
			set_opacity(0)

		if(DOOR_STATE_OPENED)
			icon_state = "[initial(icon_state)]open"
			desc = "The door is open."
			update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE)
			layer = LAYER_OBJ_DOOR_OPEN
			set_opacity(0)

		if(DOOR_STATE_CLOSED)
			icon_state = initial(icon_state)
			desc = "The door is closed."
			update_collisions(FLAG_COLLISION_WALL,FLAG_COLLISION_BULLET_INORGANIC)
			layer = LAYER_OBJ_DOOR_CLOSED
			set_opacity(initial(opacity))

obj/structure/interactive/door/proc/toggle(var/mob/caller,var/lock = FALSE,var/force = FALSE)
	if(door_state == DOOR_STATE_OPENED)
		close(caller)
		return TRUE
	else if(door_state == DOOR_STATE_CLOSED)
		open(caller)
		return TRUE
	return FALSE

obj/structure/interactive/door/proc/open(var/mob/caller,var/lock = FALSE,var/force = FALSE)
	if(open_sound)
		play_sound(open_sound,src.loc,range_max=VIEW_RANGE)
		if(caller) create_alert(VIEW_RANGE,src.loc,caller,ALERT_LEVEL_NOISE)
	door_state = DOOR_STATE_OPENING_01
	update_sprite()
	spawn(open_time)
		door_state = DOOR_STATE_OPENED
		update_sprite()


obj/structure/interactive/door/proc/close(var/mob/caller,var/lock = FALSE,var/force = FALSE)
	if(close_sound)
		play_sound(close_sound,src.loc,range_max=VIEW_RANGE)
		if(caller) create_alert(VIEW_RANGE,src.loc,caller,ALERT_LEVEL_NOISE)
	door_state = DOOR_STATE_CLOSING_01
	update_sprite()
	spawn(close_time)
		door_state = DOOR_STATE_CLOSED
		update_sprite()

/obj/structure/interactive/door/proc/unlock(var/mob/caller,var/force = FALSE)
	locked = FALSE
	update_sprite()
	return TRUE

/obj/structure/interactive/door/proc/lock(var/mob/caller,var/force = FALSE)
	locked = TRUE
	update_sprite()
	return TRUE

obj/structure/interactive/door/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_CHECK_OBJECT
	INTERACT_DELAY(1)

	var/atom/A = check_interactables(caller,object,location,control,params)
	if(A && A.clicked_on_by_object(caller,object,location,control,params))
		return TRUE

	if(door_state == DOOR_STATE_OPENED && allow_manual_close)
		close(caller)
	else if(door_state == DOOR_STATE_CLOSED && allow_manual_open)
		open(caller)

	return TRUE

obj/structure/interactive/door/wood
	name = "wooden door"

obj/structure/interactive/door/metal
	name = "iron door"
	icon_state = "silver"
	color = "#888888"