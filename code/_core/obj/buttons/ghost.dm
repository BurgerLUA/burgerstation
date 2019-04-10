/obj/button/join
	name = "join a team"
	desc = ""
	icon_state = "join_red"
	screen_loc = "CENTER,BOTTOM"
	var/desired_team_id

/obj/button/join/clicked_by_object(var/mob/caller,object,location,control,params)

	if(!is_observer(caller))
		caller << "You are not an observer! Please yell at Burger and tell them to fix this."
		return TRUE

	var/list/valid_spawns = list()
	for(var/obj/structure/interactive/wishgranter/spawn_and_join_faction/W in all_wishgranters)
		if(W.faction_to_join != desired_team_id)
			continue
		valid_spawns += W

	if(!length(valid_spawns))
		caller << "Could not find any spawns for that team!"
		return TRUE

	var/obj/structure/interactive/wishgranter/spawn_and_join_faction/W = pick(valid_spawns)
	return W.clicked_by_object(caller,object,location,control,params)

/obj/button/join/red
	name = "join the red team"
	desc = "Join the red team. Red is the color of roses and communism."
	icon_state = "join_red"
	screen_loc = "CENTER-1.5,BOTTOM"
	desired_team_id = "arena_red"

/obj/button/join/blue
	name = "join the blue team"
	desc = "Join the blue team. Red is the color of the sky and autoerotic asphyxiation."
	icon_state = "join_blue"
	screen_loc = "CENTER-0.5,BOTTOM"
	desired_team_id = "arena_blue"

/obj/button/join/green
	name = "join the green team"
	desc = "Join the green team. Green is the color of grass and ass blast."
	icon_state = "join_green"
	screen_loc = "CENTER+0.5,BOTTOM"
	desired_team_id = "arena_green"

/obj/button/join/yellow
	name = "join the yellow team"
	desc = "Join the yellow team. Yellow is the color of sunflowers and snow."
	icon_state = "join_yellow"
	screen_loc = "CENTER+1.5,BOTTOM"
	desired_team_id = "arena_yellow"

/obj/button/new_character/
	name = "create a new character"
	desc = ""
	icon_state = "new_character"
	screen_loc = "CENTER-0.5,BOTTOM"

/obj/button/new_character/clicked_by_object(var/mob/caller,object,location,control,params)
	if(!is_observer(caller))
		caller << "You are not an observer! Please yell at Burger and tell them to fix this."
		return TRUE
	if(world_state != STATE_RUNNING)
		caller << "The game has not loaded yet!"
		return TRUE

	var/mob/abstract/observer/O = caller
	O.new_character()

	return TRUE

/obj/button/load_character/
	name = "load an existing character"
	desc = ""
	icon_state = "load_character"
	screen_loc = "CENTER+0.5,BOTTOM"

/obj/button/load_character/clicked_by_object(var/mob/caller,object,location,control,params)
	if(!is_observer(caller))
		caller << "You are not an observer! Please yell at Burger and tell them to fix this."
		return TRUE
	if(world_state != STATE_RUNNING)
		caller << "The game has not loaded yet!"
		return TRUE

	var/mob/abstract/observer/O = caller
	O.load_character()

	return TRUE