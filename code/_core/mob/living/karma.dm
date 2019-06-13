/mob/living/proc/add_karma(var/karma_type,var/amount)

	if(src.client)
		add_karma(amount)

	karma[karma_type] += amount
	return TRUE