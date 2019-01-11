atom/proc/activate(caller,src,location,control,params)
	return FALSE

/atom/proc/examine(var/atom/examiner) //Alt Clicking Objects
	examiner.to_chat("\icon[src] That's \a [src.name].")
	examiner.to_chat(" [src.desc]")
