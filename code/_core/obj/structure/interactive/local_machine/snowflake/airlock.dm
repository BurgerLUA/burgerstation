/obj/structure/interactive/localmachine/snowflake/airlock

	name = "glass airlock"

	icon = 'icons/obj/structure/airlock/airlock_glass_merged.dmi'
	icon_state = "closed"

	var/list/mob_to_door_state = list()

	var/default_door_state = DOOR_STATE_CLOSED

	var/open_time = 6

	var/close_time = 6

	collision_flags = FLAG_COLLISION_NONE
	collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
	opacity = 0


/obj/structure/interactive/localmachine/snowflake/airlock/clicked_on_by_object(caller,object,location,control,params)

	if(!ismob(caller))
		return TRUE

	INTERACT_CHECK

	var/mob/M = caller

	if(!mob_to_door_state[M])
		mob_to_door_state[M] = default_door_state

	switch(mob_to_door_state[M])
		if(DOOR_STATE_CLOSED)
			open_for(M)
		if(DOOR_STATE_OPENED)
			close_for(M)

	return TRUE

/obj/structure/interactive/localmachine/snowflake/airlock/proc/open_for(var/mob/M)
	mob_to_door_state[M] = DOOR_STATE_OPENING_01
	set_icon_state_mob(M,"opening")
	spawn(open_time)
		mob_to_door_state[M] = DOOR_STATE_OPENED
		set_icon_state_mob(M,"open")

/obj/structure/interactive/localmachine/snowflake/airlock/proc/close_for(var/mob/M)
	mob_to_door_state[M] = DOOR_STATE_CLOSING_01
	set_icon_state_mob(M,"closing")
	spawn(close_time)
		mob_to_door_state[M] = DOOR_STATE_CLOSED
		set_icon_state_mob(M,"closed")

/obj/structure/interactive/localmachine/snowflake/airlock/proc/bolt_for(var/mob/M)

	if(mob_to_door_state[M] == DOOR_STATE_OPENED)
		mob_to_door_state[M] = DOOR_STATE_CLOSING_01
		set_icon_state_mob(M,"closing")

		spawn(close_time)
			mob_to_door_state[M] = DOOR_STATE_LOCKED
			set_icon_state_mob(M,"closed")
	else
		mob_to_door_state[M] = DOOR_STATE_LOCKED
		set_icon_state_mob(M,"closed")

/obj/structure/interactive/localmachine/snowflake/airlock/Cross(var/atom/movable/O,var/atom/NewLoc,var/atom/OldLoc)

	if(!ismob(O))
		return ..()

	var/mob/M = O

	if(!mob_to_door_state[M])
		mob_to_door_state[M] = default_door_state

	if(mob_to_door_state[M] == DOOR_STATE_CLOSED)
		open_for(M)
		return FALSE
	else if(mob_to_door_state[M] == DOOR_STATE_OPENING_01)
		return FALSE

	return ..()

/obj/structure/interactive/localmachine/snowflake/airlock/external
	name = "external airlock"
	icon = 'icons/obj/structure/airlock/airlock_external_merged.dmi'
	icon_state = "closed"


var/global/list/obj/structure/interactive/localmachine/snowflake/airlock/external/tutorial_dock/tutorial_docks = list()

/obj/structure/interactive/localmachine/snowflake/airlock/external/tutorial_dock/New(var/desired_loc)
	. = ..()
	tutorial_docks += src
	