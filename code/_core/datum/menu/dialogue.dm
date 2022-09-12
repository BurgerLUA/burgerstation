/menu/dialogue/
	file = 'html/dialogue.html'
	resources = list(
		"tile.png" = 'html/tile.png',
	)

/menu/dialogue/open(var/mob/user)
	cache_resources(user)
	winset(user, "map.dialogue","is-visible=true")
	sleep(1)
	user << output(file, "map.dialogue")

/menu/dialogue/on_load(var/mob/user)

	if(!is_player(user))
		return FALSE

	var/mob/living/advanced/player/P = user

	if(!P.dialogue_target_id)
		log_error("ERROR: [P.get_debug_name()] could not access dialogue as they had an invalid dialogue target id!")
		return FALSE

	var/dialogue/D = SSdialogue.all_dialogue[P.dialogue_target_id]
	if(!D)
		log_error("ERROR: [user] cannot access dialogue ID [P.dialogue_target_id ? P.dialogue_target_id : "NULL"] for mob [P.dialogue_target.get_debug_name()]!")
		return FALSE

	run_function(P,"set_reference","'\ref[src]'")

	D.add_stored_topics_if_exist(P)

	run_function(P,"set_name","'[P.dialogue_target.name]'")

/menu/dialogue/close(var/mob/user)
	winset(user, "map.dialogue","is-visible=false")
	winset(user,"map.map","focus=true")
	winset(user,"control.input","focus=false")

/menu/dialogue/run_function(var/mob/user, var/function_name,var/args)
	user << output("[function_name]([args]);", "map.dialogue:eval")

/menu/dialogue/Topic(href,href_list)

	if(length(href_list) && href_list["topic"] && is_player(usr))
		var/mob/living/advanced/player/P = usr
		if(href_list["topic"] == "goodbye")
			close(P)
			return
		var/dialogue/D = SSdialogue.all_dialogue[P.dialogue_target_id]
		D.set_topic(P,href_list["topic"])

	return ..()