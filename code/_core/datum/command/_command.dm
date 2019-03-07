/command/
	var/name = "Command Name"
	var/desc = "What the command does."
	var/id = "ID of the command." //Or what it's used to call by.
	var/permission = 0

/command/proc/run_command(var/mob/user,var/list/params)
	return TRUE