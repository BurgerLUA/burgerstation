/atom/proc/clicked_by_object(caller,object,location,control,params)
	return FALSE

/atom/proc/drop_on_object(var/atom/caller,var/atom/object)
	if(object && object.dropped_by_object(caller,src))
		return TRUE

	return FALSE

/atom/proc/dropped_by_object(caller,object)
	return FALSE

/atom/proc/get_examine_text(var/mob/examiner)
	return div("examine_title","[src.name]") + div("examine_description","\"[src.desc]\"") + div("examine_description_long","[src.desc_extended]")

/*
/atom/proc/examine(var/mob/examiner) //Middle clicking objects.
	examiner.to_chat(get_examine_text(examiner))
	return TRUE
*/

/atom/proc/click_self(caller,location,control,params)
	return FALSE
