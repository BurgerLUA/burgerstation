/choice/
	var/id = null

	var/question = "skip_tutorial"
	var/list/options = list("yes","no")

	var/stored_buttons = list()
	var/mob/owner
	var/choice_made = null

/choice/New(var/mob/desired_owner)

	if(desired_owner)
		owner = desired_owner

	var/desired_question = question_button_id_to_button[question]
	var/obj/hud/button/question/Q = new desired_question(desired_owner)
	Q.update_owner(owner)
	stored_buttons += Q

	for(var/option in options)
		var/desired_button = choice_button_id_to_button[option]
		var/obj/hud/button/choice/B = new desired_button(desired_owner,src)
		B.update_owner(owner)
		stored_buttons += B

	return ..()

/choice/Destroy()

	for(var/obj/hud/button/B in stored_buttons)
		B.update_owner(null)

	owner = null

	return ..()

/choice/proc/on_decision()
	//If you want to do anything fancy here.
	return choice_made