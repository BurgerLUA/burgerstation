/command/
	name = "Command Name"
	desc = "What the command does."
	id = null
	var/permission = 0

/command/proc/run_command(var/mob/user,var/list/params)

	if(!user.client)
		return FALSE

	if(!(user.client.get_permissions() & permission))
		return FALSE

	return TRUE