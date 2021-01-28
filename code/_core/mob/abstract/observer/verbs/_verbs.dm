/mob/abstract/observer/add_inherent_verbs()
	verbs += /mob/abstract/observer/verb/new_character
	verbs += /mob/abstract/observer/verb/load_character
	verbs += /mob/abstract/observer/verb/load_most_recent_character
	verbs += /mob/abstract/observer/verb/become_antagonist
	verbs += /mob/abstract/observer/verb/observe

	if(client)
		client.verbs += /client/verb/jump_to_player
		client.verbs += /client/verb/jump_to_area
		client.verbs += /client/verb/jump_to_mob
		client.verbs += /client/verb/adjust_nightvision

	return ..()

/mob/abstract/observer/verb/observe()
	set name = "Observe"
	set category = "Menu"

	if(!client)
		return FALSE

	var/decision = input("Are you sure you want to observe? You can join again any time you want.","Observe Round?") as null|anything in list("Yes","No","Cancel")
	if(decision != "Yes")
		return FALSE

	if(type == /mob/abstract/observer/ghost)
		to_chat(span("warning","You are already observing!"))
		return FALSE

	client.make_ghost(get_turf(src))