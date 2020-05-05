/mob/abstract/observer/add_inherent_verbs()
	verbs += /mob/abstract/observer/verb/new_character
	verbs += /mob/abstract/observer/verb/load_character
	verbs += /mob/abstract/observer/verb/load_most_recent_character
	verbs += /mob/abtract/observer/verb/move_up
	verbs += /mob/abtract/observer/verb/move_down
	return ..()



/mob/abtract/observer/verb/move_up()
	set name = "Move Up"
	set category = "Ghost"
	var/turf/T = locate(x,y,z+1)

	if(T)
		force_move(T)



/mob/abtract/observer/verb/move_down()
	set name = "Move Down"
	set category = "Ghost"
	var/turf/T = locate(x,y,z-1)

	if(T)
		force_move(T)