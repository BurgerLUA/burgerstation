/emote/
	var/name = "Emote"
	var/desc = "Emote description."
	var/id

/emote/proc/on_emote(var/atom/emoter,var/atom/target)
	//When the emote is triggered
	for(var/mob/living/advanced/player/P in view(8,src))
		//Teach the emote to all those who saw it.