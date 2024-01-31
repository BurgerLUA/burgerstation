/ai/advanced/taxman
	aggression = 1
	assistance = 1

/ai/advanced/taxman/is_enemy(atom/A,safety_check=TRUE,aggression_check=TRUE)

	if(is_player(A))
		var/mob/living/advanced/player/P = A
		if(SStax.check_delinquent(P))
			return TRUE

	. = ..()