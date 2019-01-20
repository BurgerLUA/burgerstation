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
			P.client.update_zoom(0)
		del(O)

/obj/trigger/move_to_world
	name = "move to world"
	desc = "move to the world"

/obj/trigger/move_to_world/on_trigger(var/atom/triggerer)
	if(is_advanced(triggerer))
		var/mob/living/advanced/A = triggerer
		A.loc = pick(world_spawnpoints)
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
	var/do_save = FALSE

/obj/trigger/jumploc/on_trigger(var/atom/movable/triggerer)
	triggerer.loc = locate(x + x_move, y + y_move,z)

	if(do_save && is_advanced(triggerer))
		var/mob/living/advanced/A = triggerer
		if(A.client)
			A.client.save_current_character()