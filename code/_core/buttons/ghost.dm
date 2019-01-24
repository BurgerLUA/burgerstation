/obj/button/join_red
	name = "join the red team"
	desc = "Spawn in and join the red team"
	icon_state = "join_red"
	screen_loc = "CENTER-0.5,BOTTOM"

/obj/button/join_red/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!is_observer(caller))
		return TRUE

	var/list/valid_spawns = list()
	for(var/obj/structure/interactive/wishgranter/spawn_and_join_faction/W in all_wishgranters)
		if(W.faction_to_join != "arena_red")
			continue

		valid_spawns += W

	if(!length(valid_spawns))
		return TRUE

	var/obj/structure/interactive/wishgranter/spawn_and_join_faction/W = pick(valid_spawns)
	return W.clicked_by_object(caller,object,location,control,params)

/obj/button/join_blue
	name = "join the blue team"
	desc = "Spawn in and join the blue team"
	icon_state = "join_blue"
	screen_loc = "CENTER+0.5,BOTTOM"

/obj/button/join_blue/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!is_observer(caller))
		caller << "You're not an observer!"
		return TRUE

	var/list/valid_spawns = list()
	for(var/obj/structure/interactive/wishgranter/spawn_and_join_faction/W in all_wishgranters)
		if(W.faction_to_join != "arena_blue")
			continue

		valid_spawns += W

	if(!length(valid_spawns))
		caller << "Could not find any valid spawns..."
		return TRUE

	var/obj/structure/interactive/wishgranter/spawn_and_join_faction/W = pick(valid_spawns)
	return W.clicked_by_object(caller,object,location,control,params)
