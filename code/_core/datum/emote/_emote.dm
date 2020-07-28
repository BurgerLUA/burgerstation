/emote/
	var/name = "Emote"
	var/id = null

	var/action = "\The #USER stares as they cannot scream."
	var/action_target

/emote/proc/can_emote(var/atom/emoter,var/atom/target)
	return TRUE

/emote/proc/on_emote(var/atom/emoter,var/atom/target)

	if(!target || !action_target)
		emoter.visible_message(span("emote",replacetextEx(action,"#USER","<b>[emoter.name]</b>")))
	else
		emoter.visible_message(span("emote",replacetextEx(action_target,"#USER","<b>[emoter.name]</b>")))

	return TRUE