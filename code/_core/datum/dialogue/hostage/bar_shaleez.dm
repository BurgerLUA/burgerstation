/dialogue/hostage/bar_shaleez/


/dialogue/hostage/bar_shaleez/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = ..()

	var/mob/living/advanced/A = P.dialogue_target

	if(istype(A) && A.handcuffed)
		.["hello"] = list(
			"Ah, a sssavior. Pleassse get thessse #1ss off me.",
			"handcuffs",
			"*wait here",
			"*follow me"
		)
	else
		.["hello"] = list(
			pick("I would go back to the ssstation myssself but I don't know where to go!","Have you come to ressscue me?"),
			"*wait here",
			"*follow me"
		)

	.["handcuffs"] = list(
		"You can remove handcuffsss by examining me, and then removing my cuffsss."
	)

	return .