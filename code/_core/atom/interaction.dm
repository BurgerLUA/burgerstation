/atom/proc/clicked_by_object(caller,object,location,control,params)
	return FALSE

/atom/proc/drop_on_object(caller,object)
	if(dropped_by_object(caller,object))
		return TRUE

	return FALSE

/atom/proc/dropped_by_object(caller,object)
	return FALSE

/atom/proc/examine(var/mob/examiner) //Middle clicking objects.
	examiner.to_chat(span("examine_title","[src.name]"))
	examiner.to_chat(span("examine_description","\"[src.desc]\""))
	examiner.to_chat(span("examine_description_long","[src.desc_extended]"))
	return TRUE

/atom/proc/click_self(caller,location,control,params)
	return FALSE
