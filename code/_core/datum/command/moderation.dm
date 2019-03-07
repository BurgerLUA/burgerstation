/command/kick
	name = "Kick"
	desc = "Kicks the target ckey."
	id = "kick"
	permission = FLAG_PERMISSION_MODERATOR

/command/kick/run_command(var/mob/user,var/list/params)

	if(!user.client)
		return FALSE

	var/client/C = user.client
	var/client/T = params["target"]
