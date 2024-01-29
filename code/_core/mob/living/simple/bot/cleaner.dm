/mob/living/simple/bot/cleaner
	name = "cleaning bot"
	desc = "The legally distinct cleaning bot that cleans messes!"
	icon = 'icons/mob/living/simple/cleaner.dmi'
	icon_state = "living"

	loyalty_tag = "NanoTrasen"
	iff_tag = "NanoTrasen"

	ai = /ai/bot/cleaner

	var/owner_ckey

	value = 200

	health_base = 200

/mob/living/simple/bot/cleaner/post_death()

	. = ..()

	if(.)
		icon_state = "dead"

/mob/living/simple/bot/cleaner/post_move(atom/old_loc)

	. = ..()

	if(. && loc != old_loc && loc && is_turf(loc))

		var/sucked = FALSE
		var/turf/T = loc

		for(var/obj/effect/cleanable/C in T.contents)
			qdel(C)
			sucked = TRUE

		if(sucked)
			play_sound('sound/effects/portal_suck.ogg',T)