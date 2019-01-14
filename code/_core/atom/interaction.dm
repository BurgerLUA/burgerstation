/atom/proc/clicked_by_object(caller,object,location,control,params)
	if(src == object)
		return click_self(caller,location,control,params)
	return FALSE

/atom/proc/drop_on_object(caller,object)

	if(dropped_by_object(caller,object))
		return TRUE

	return FALSE

/atom/proc/dropped_by_object(caller,object)
	return FALSE

/atom/proc/examine(var/atom/examiner) //Alt Clicking Objects
	examiner.to_chat("\icon[src] That's \a [src.name].")
	examiner.to_chat(" [src.desc]")
	return TRUE


/atom/proc/click_self(caller,location,control,params)
	return FALSE
