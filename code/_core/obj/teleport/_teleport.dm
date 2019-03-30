/obj/trigger/
	name = "trigger"
	desc = "This triggers something."
	icon = null
	icon_state = null

/obj/trigger/Crossed(var/atom/crosser)
	..()
	on_trigger(crosser)

/obj/trigger/proc/on_trigger(var/atom/triggerer)
	return TRUE

/*
/obj/trigger/new_character
	name = "new character teleport trigger"
	desc = "turns the person into a player"

/obj/trigger/new_character/on_trigger(var/atom/triggerer)
	if(is_observer(triggerer))
		var/mob/abstract/observer/O = triggerer
		var/mob/living/advanced/player/P = new(pick(spawnpoints_new_character),O.client)
		P.Initialize()
		if(P.client)
			P.client.eye = P
			P.client.update_zoom(-1)
		qdel(O)

/obj/trigger/move_to_world
	name = "move to world"
	desc = "move to the world"

/obj/trigger/move_to_world/on_trigger(var/atom/triggerer)
	if(is_advanced(triggerer))
		var/mob/living/advanced/A = triggerer
		A.force_move(pick(world_spawnpoints))
		if(A.client)
			A.client.save_current_character()
*/


/obj/trigger/no_entry
	name = "no entry"
	var/message = "You cannot go that way."

/obj/trigger/no_entry/on_trigger(var/mob/triggerer)
	triggerer.to_chat(span("notice",message))

/obj/trigger/jumploc
	name = "loc jumper"
	var/x_move = 0
	var/y_move = 0
	var/dir_restriction = 0

/obj/trigger/jumploc/on_trigger(var/atom/movable/triggerer)

	if(!is_living(triggerer))
		return FALSE

	if(!(triggerer.dir & dir_restriction))
		return FALSE

	triggerer.Move(locate(x + x_move, y + y_move,z))

/obj/trigger/jumploc/north
	x_move = 0
	y_move = 2
	dir_restriction = NORTH

/obj/trigger/jumploc/south
	x_move = 0
	y_move = -2
	dir_restriction = SOUTH

/obj/trigger/jumploc/east
	x_move = 2
	y_move = 0
	dir_restriction = EAST

/obj/trigger/jumploc/west
	x_move = -2
	y_move = 0
	dir_restriction = WEST


/obj/trigger/jumplevel
	name = "level jumper"
	var/desired_x = 0
	var/desired_y = 0
	var/desired_map = ""
	var/dir_restriction = 0

/obj/trigger/jumplevel/on_trigger(var/atom/movable/triggerer)

	if(!is_mob(triggerer))
		triggerer << "You're not a mob!"
		return FALSE

	if(dir_restriction != 0 && !(triggerer.dir & dir_restriction))
		triggerer << "Direction restriction!"
		return FALSE

	triggerer << "Moving!"

	triggerer.Move(locate(desired_x,desired_y,get_z_level(desired_map)))

	return TRUE
