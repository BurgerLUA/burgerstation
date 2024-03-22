
/mob/living/proc/can_add_minion(var/mob/living/minion_to_add)


	return TRUE

/mob/living/proc/add_minion(var/mob/living/minion_to_add)

	if(minion_to_add.minion_master)
		return FALSE //Already belongs to a master.

	if(!src.minions)
		src.minions = list()
	src.minions += minion_to_add
	minion_to_add.minion_master = src
	minion_to_add.set_iff_tag(src.iff_tag)
	minion_to_add.set_loyalty_tag(src.loyalty_tag)
	minion_to_add.ai.set_move_objective(src,2,astar=TRUE,follow=TRUE)

	while(length(minions) > max(1,1 + get_skill_power(SKILL_SUMMONING,0,1,2)*3))
		var/mob/living/L = minions[1]
		src.remove_minion(L)

	return TRUE

/mob/living/proc/remove_minion(var/mob/living/minion_to_remove) //This also kills the minion

	if(minion_to_remove.minion_master != src)
		return FALSE //Not yours.

	minion_to_remove.minion_master = null
	src.minions -= minion_to_remove

	if(!minion_to_remove.qdeleting && !minion_to_remove.dust(TRUE) && !qdeleting)
		qdel(minion_to_remove) //Safety, as dust can sometimes return FALSE

	return TRUE

