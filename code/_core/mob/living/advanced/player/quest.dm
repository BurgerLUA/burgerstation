mob/living/advanced/player/proc/add_quest(var/quest/desired_quest_path,var/desired_stage=1)

	if(quests[desired_quest_path])
		return FALSE

	var/quest/Q = new desired_quest_path
	Q.owner = src
	quests[desired_quest_path] = Q
	Q.set_stage(desired_stage,force=TRUE)

	return Q


mob/living/advanced/player/proc/set_quest_stage(var/quest/desired_quest_path,var/desired_stage=1,var/force=FALSE)

	if(!quests[desired_quest_path])
		return FALSE

	var/quest/Q = quests[desired_quest_path]
	return Q.set_stage(desired_stage,force=force)