/ai/proc/do_dialogue(var/response_type,var/swear_chance=10)
	if(!active || owner.dead)
		return FALSE
	var/returning_dialogue = SSdialogue.get_combat_dialogue(owner.combat_dialogue,response_type,swear_chance)
	next_talk = world.time + SECONDS_TO_DECISECONDS(5)
	if(returning_dialogue)
		owner.do_say(returning_dialogue,language_to_use = owner.default_language)
	return TRUE