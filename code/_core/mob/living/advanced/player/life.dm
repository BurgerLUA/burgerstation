
/mob/living/advanced/player/on_life()

	if(area && !area.safe)
		var/was_protected = spawn_protection > 0
		spawn_protection =  max(0,spawn_protection - LIFE_TICK)
		if(!spawn_protection && was_protected)
			src.to_chat(span("notice","Your spawn protection has worn off."))

	return ..()

/*
/mob/living/advanced/player/handle_alpha()

	if(spawn_protection > 0 && !area.safe)
		return 10

	return ..()
*/