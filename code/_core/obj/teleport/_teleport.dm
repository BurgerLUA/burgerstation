/obj/trigger/
	name = "trigger"
	desc = "This triggers something."
	icon = null
	icon_state = null

/obj/trigger/proc/on_trigger(var/atom/triggerer)
	return TRUE

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

/obj/trigger/no_entry
	name = "no entry"
	var/message = "You cannot go that way."

/obj/trigger/no_entry/on_trigger(var/atom/triggerer)
	triggerer.to_chat(span("notice",message))


/obj/trigger/jumploc
	name = "loc jumper"
	var/x_move = 0
	var/y_move = 0

/obj/trigger/jumploc/on_trigger(var/atom/movable/triggerer)

	if(!is_living(triggerer))
		return FALSE

	triggerer.force_move(locate(x + x_move, y + y_move,z),FALSE,TRUE)

/obj/trigger/jumploc/north
	x_move = 0
	y_move = 2

/obj/trigger/jumploc/south
	x_move = 0
	y_move = -2
/obj/trigger/jumploc/east
	x_move = 2
	y_move = 0

/obj/trigger/jumploc/west
	x_move = -2
	y_move = 0

/obj/trigger/telesmart
	name = "smart jumper"
	var/desired_dir = 0

/obj/trigger/telesmart/up
	desired_dir = UP

/obj/trigger/telesmart/down
	desired_dir = DOWN

/obj/trigger/telesmart/on_trigger(var/atom/movable/triggerer)

	var/final_x = triggerer.x
	var/final_y = triggerer.y
	var/final_z = triggerer.z

	if(desired_dir & UP)
		final_z += 1

	if(desired_dir & DOWN)
		final_z -= 1

	if(desired_dir & (WEST | EAST))
		final_x = 128 - final_x

	if(desired_dir & (NORTH | SOUTH))
		final_y = 128 - final_x

	triggerer.force_move(locate(final_x,final_y,final_z),FALSE,TRUE)