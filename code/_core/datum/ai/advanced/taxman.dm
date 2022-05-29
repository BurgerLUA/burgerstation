/ai/advanced/taxman
	aggression = 0
	assistance = 1

/ai/advanced/taxman/is_enemy(var/atom/A,var/safety_check=TRUE,var/aggression_check=TRUE)


	if(is_player(A))
		var/mob/living/advanced/player/P = A
		if(SStax.check_delinquent(P))
			return TRUE

	. = ..()