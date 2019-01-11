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
		var/mob/living/advanced/human = new(pick(spawnpoints_new_character),O.client)
		human.Initialize()
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

