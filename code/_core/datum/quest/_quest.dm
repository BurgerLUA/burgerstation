#define FLAG_QUEST_LIFE_ONLY 0x1 //Quest is valid for your life only. It is removed on death.
#define FLAG_QUEST_SESSION_ONLY 0x2 //Quest is only valid when the server is up. It is removed when the server restarts.

/quest/
	name = "Quest"
	id = null
	desc = "" //Short description.
	desc_extended = "" //Long description.

	var/quest_flags = 0
	var/objectives = list()


	//Internal Values
	var/stage = 0
	var/mob/owner

	var/list/objectives_displayed = list()
	var/list/objectives_completed = list()

/quest/proc/on_death()
	return FALSE

/quest/proc/can_change_stage(var/desired_stage)
	return TRUE

/quest/proc/set_stage(var/desired_stage)
	if(!can_change_stage(desired_stage))
		return FALSE
	var/old_stage = stage
	stage = desired_stage
	on_stage_changed(old_stage)
	return TRUE

/quest/proc/get_objectives_html()
	var/returning = "<span class='quest_objectives'>"
	for(var/v in objectives_displayed)
		if(v in objectives_completed)
			returning += "<span class='completed_objective'>[objectives[v]]</span>"
		else
			returning += "<span class='objective'>[objectives[v]]</span>"
	returning += "</span>"

	return returning

/quest/proc/set_objective_displayed(var/objective_id)
	objectives_displayed += objective_id

/quest/proc/set_objective_completed(var/objective_id)
	objectives_completed += objective_id

/quest/proc/on_stage_changed(var/previous_stage)
	return TRUE

/quest/proc/on_load(var/loaded_stage) //Quest was loaded from a save file and applied to a mob.

	if(quest_flags & (FLAG_QUEST_SESSION_ONLY | FLAG_QUEST_LIFE_ONLY))
		qdel(src)
		return FALSE

	set_stage(loaded_stage)
	return TRUE