/command/kick
	name = "Kick"
	desc = "Kicks the target ckey."
	id = "kick"
	permission = FLAG_PERMISSION_MODERATOR

/command/kick/run_command(var/mob/user,var/list/params)

	. = ..()

	if(!.)
		return .

	var/client/C = user.client
	var/client/T = params["target"]

	var/length = 60
	var/reason = sanitize(params["reason"])
	var/nice_time = get_nice_time(length)

	var/message = "You have been kicked for the following reason: \"[reason]\". You'll be able to rejoin in [english_list(nice_time)]."

	world.SetConfig("ban",T.ckey,"type=time;seconds=[length];reason=[reason];message=[message];admin=[C.ckey];IP=[C.address];computer_id=[C.computer_id];")
	return TRUE
