/menu/dialogue/
	name = "Dialogue Menu"
	id = "dialogue"

	file = 'html/dialogue.html'
	resources = list(
		"tile.png" = 'html/tile.png',
	)

/menu/dialogue/open(var/user)
	cache_resources(user)
	winset(user, "map.dialogue","is-visible=true")
	sleep(1)
	user << output(file, "map.dialogue")

/menu/dialogue/on_load(var/user)

	run_function(usr,"set_reference","'\ref[src]'")

	if(!is_player(user))
		return FALSE

	var/mob/living/advanced/player/P = user

	var/dialogue/D = all_dialogue[P.dialogue_target_id]
	D.set_topic(P,"hello")
	run_function(usr,"set_name","'[D.name]'")

/menu/dialogue/close(var/user)
	winset(user, "map.dialogue","is-visible=false")

/menu/dialogue/run_function(var/user, var/function_name,var/args)
	user << output("[function_name]([args]);", "map.dialogue:eval")

/menu/dialogue/Topic(href,href_list)
	if(length(href_list) && href_list["topic"] && is_player(usr))
		var/mob/living/advanced/player/P = usr
		if(href_list["topic"] == "goodbye")
			close(usr)
			return
		var/dialogue/D = all_dialogue[P.dialogue_target_id]
		D.set_topic(P,href_list["topic"])