#define FLAG_QUEST_LIFE_ONLY 0x1 //Quest is valid for your life only. It is removed when you respawn.
#define FLAG_QUEST_SESSION_ONLY 0x2 //Quest is only valid when the server is up. It is removed when the server restarts.
//If not these two flags, the quest is permanent.

/quest/
	var/name = "Quest"
	var/desc = "" //Short description.
	var/desc_extended = "" //Long description.

	var/quest_flags = 0
	var/objectives = list()

	//Internal Values
	var/stage = 0
	var/mob/owner

	var/list/objectives_displayed = list()
	var/list/objectives_completed = list()

/quest/Destroy()
	owner = null
	stage = -1
	. = ..()

/quest/proc/on_death()
	return FALSE

/quest/proc/can_change_stage(desired_stage)
	return TRUE

/quest/proc/set_stage(desired_stage,force=FALSE)
	if(!force && !can_change_stage(desired_stage))
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

/quest/proc/set_objective_displayed(objective_id)
	objectives_displayed += objective_id

/quest/proc/set_objective_completed(objective_id)
	objectives_completed += objective_id

/quest/proc/on_stage_changed(previous_stage)
	return TRUE

/quest/proc/on_load(loaded_stage) //Quest was loaded from a save file and applied to a mob.
	set_stage(loaded_stage)
	return TRUE