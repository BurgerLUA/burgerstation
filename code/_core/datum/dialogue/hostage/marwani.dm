/dialogue/hostage/marwani/


/dialogue/hostage/marwani/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = ..()

	var/mob/living/advanced/A = P.dialogue_target

	if(istype(A) && A.handcuffed)
		.["hello"] = list(
			"Oh! You're here! Pleassse remove thessse dreadful #1ss and essscort me to sssafety!",
			"handcuffs",
			"*wait here",
			"*follow me"
		)
	else
		.["hello"] = list(
			pick("Pleassse get me to sssafety. I don't want to be here anymore."),
			"*wait here",
			"*follow me"
		)

	.["handcuffs"] = list(
		"Oh. Jussst examine me and you ssshould sssee a way to remove cuffsss."
	)

	return .