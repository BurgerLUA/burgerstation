/command/
	var/name = "Command Name"
	var/desc = "What the command does."
	var/id = "ID of the command." //Or what it's used to call by.
	var/permission = 0

/command/proc/run_command(var/mob/user,var/list/params)

	if(!user.client)
		return FALSE

	if(!(user.client.get_permissions() & permission))
		return FALSE

	return TRUE