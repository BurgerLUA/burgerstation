/dialogue/hostage/assistant/


/dialogue/hostage/assistant/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = ..()

	var/mob/living/advanced/A = P.dialogue_target

	if(istype(A) && A.handcuffed)
		.["hello"] = list(
			"fucking shitsec bucklecuffed me. get these fucking #1 off me",
			"handcuffs",
			"*wait here",
			"*follow me"
		)
	else
		.["hello"] = list(
			pick("where to, buckaroo"),
			"*wait here",
			"*follow me"
		)

	.["handcuffs"] = list(
		"yeah dude just examine me and remove my cuffs"
	)

	return .