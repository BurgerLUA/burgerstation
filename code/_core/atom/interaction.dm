atom/proc/click_on(control,params)
	//Click on stuff

/atom/proc/examine(var/atom/examiner) //Alt Clicking Objects
	examiner.to_chat("\icon[src] That's \a [src.name].")
	examiner.to_chat(" [src.desc]")
