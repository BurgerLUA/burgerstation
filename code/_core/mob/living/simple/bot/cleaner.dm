/mob/living/simple/bot/cleaner
	name = "cleaning bot"
	desc = "The legally distinct cleaning bot that collects items!"
	icon = 'icons/mob/living/simple/cleaner.dmi'
	icon_state = "living"

	loyalty_tag = "NanoTrasen"
	iff_tag = "NanoTrasen"

	ai = /ai/bot/cleaner

	var/owner_ckey

	var/next_sell = 0

	var/item_contents = 0

	value = 200

	health_base = 200

/mob/living/simple/bot/cleaner/post_death()

	. = ..()

	if(.)
		var/turf/T = get_turf(src)
		if(T)
			for(var/k in contents)
				var/atom/movable/M = k
				M.force_move(T)
		icon_state = "dead"
		qdel(src)



/mob/living/simple/bot/cleaner/on_life_slow()

	. = ..()

	if(next_sell >= world.time || item_contents >= 40)

		var/total_value = 0
		for(var/obj/item/I in src.contents)
			if(!I || I.qdeleting)
				continue
			if(I.loc != src)
				continue
			if(owner_ckey)
				total_value += I.get_value()
			qdel(I)
			CHECK_TICK(50,FPS_SERVER)

		if(total_value > 0 && owner_ckey)
			total_value *= 0.25
			total_value = CEILING(total_value,1)
			var/client/C = CLIENT(owner_ckey)
			if(C.mob && is_player(C.mob))
				var/mob/living/advanced/player/A = C.mob
				A.adjust_currency(total_value)
				A.to_chat(span("notice","You have gained [total_value] credits from \the [src.name]."))

		next_sell = world.time + SECONDS_TO_DECISECONDS(60)
		item_contents = 0

/mob/living/simple/bot/cleaner/post_move(var/atom/old_loc)

	. = ..()

	if(loc != old_loc && item_contents < 40 && loc && is_turf(loc))
		var/sucked = FALSE
		var/turf/T = loc
		var/limit = 10
		for(var/obj/item/I in T.contents)
			if(limit <= 0)
				break
			if(item_contents >= 40)
				break
			if(I.anchored)
				continue
			if(I.loc != T)
				continue
			I.force_move(src)
			sucked = TRUE
			item_contents++
			limit--

		for(var/obj/effect/cleanable/C in T.contents)
			qdel(C)

		if(sucked)
			play_sound('sound/effects/portal_suck.ogg',T)
			next_sell = max(next_sell,world.time + SECONDS_TO_DECISECONDS(10))