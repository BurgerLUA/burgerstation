/command/





/proc/get_usr_proper(var/desired_type)

	if(istype(usr,desired_type))
		return usr

	if(ispath(desired_type,/client/) && istype(usr,/mob/))
		var/mob/M = usr
		if(istype(M.client,desired_type))
			return M.client

	if(ispath(desired_type,/mob/) && istype(usr,/client/))
		var/client/C = usr
		if(istype(C.mob,desired_type))
			return C.mob

	CRASH("Could not properly get [desired_type] from [usr.type]!")