/dialogue/hostage/diamond_with_flaw/


/dialogue/hostage/diamond_with_flaw/get_dialogue_options(var/mob/living/advanced/player/P,var/list/known_options)

	. = ..()

	var/mob/living/advanced/A = P.dialogue_target

	if(istype(A) && A.handcuffed)
		.["hello"] = list(
			"Oh. Hello... there. Are you... the one... that is going to... save me? Please remove... these... #1... if you wish to... save me... if not... I can wait... a little while... longer...",
			"handcuffs",
			"*wait here",
			"*follow me"
		)
	else
		.["hello"] = list(
			pick("It is... a nice day... today... is it?"),
			"*wait here",
			"*follow me"
		)

	.["handcuffs"] = list(
		"First... you... examine me... then you... remove my... handcuffs..."
	)

	return .