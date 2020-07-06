/obj/trigger/
	name = "trigger"
	invisibility = 101

/obj/trigger/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	. = ..()
	on_trigger(O)
	return .

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
		A.force_move(get_turf(pick(world_spawnpoints)))
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

	if(!(triggerer.move_dir & dir_restriction))
		return FALSE

	var/turf/T = locate(src.x + x_move, y + src.y_move,z)

	triggerer.force_move(T)

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

/*
/obj/trigger/jumplevel
	name = "level jumper"
	var/desired_x = 0
	var/desired_y = 0
	var/desired_map = ""
	var/dir_restriction = 0

/obj/trigger/jumplevel/on_trigger(var/atom/movable/triggerer)

	if(!ismob(triggerer))
		return FALSE

	if(dir_restriction != 0 && !(triggerer.dir & dir_restriction))
		return FALSE

	triggerer.Move(locate(desired_x,desired_y,get_z_level(desired_map)))

	return TRUE
*/

/obj/trigger/jumpmarker
	name = "marker jumper"
	var/desired_marker = ""
	var/dir_restriction = 0

/obj/trigger/jumpmarker/on_trigger(var/atom/movable/triggerer)

	if(!ismob(triggerer))
		return FALSE

	if(dir_restriction != 0 && !(triggerer.dir & dir_restriction))
		return FALSE

	var/turf/T = get_turf(teleport_locations[desired_marker])

	triggerer.force_move(T)

/obj/trigger/jumpmarker/clockwork_exit
	desired_marker = "clockwork_exit"

/*
/obj/trigger/transparency_trigger
	name = "transparency trigger"
	desc = "Adjusts transparency."
	icon = null
	icon_state = null

	var/obj/structure/scenery/linked_object

/obj/trigger/transparency_trigger/New(var/new_loc,var/atom/new_linked_object)
	..()
	linked_object = new_linked_object

/obj/trigger/transparency_trigger/Crossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	..()

	linked_object.crossed_objects += O

	spawn
		if(length(linked_object.crossed_objects))
			animate(linked_object,alpha = 100, time = SECONDS_TO_DECISECONDS(0.7))

/obj/trigger/transparency_trigger/Uncrossed(var/atom/movable/O,var/atom/new_loc,var/atom/old_loc)
	..()

	linked_object.crossed_objects -= O

	spawn
		if(!length(linked_object.crossed_objects))
			animate(linked_object,alpha = 255, time = SECONDS_TO_DECISECONDS(0.7))
*/

