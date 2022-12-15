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

	var/turn_mode = 0

	var/turn_angle = 90

/mob/living/simple/bot/cleaner/Move(var/atom/NewLoc,var/Dir=0x0,var/step_x=0,var/step_y=0)

	if(!ai)
		return ..()

	if(ai.last_movement_proc == "cleaning")
		if(turn_mode > 0)
			if(turn_mode % 2) //Every odd, turn and don't move.
				src.set_dir(turn(src.dir,turn_angle))
				if(turn_angle == 180 || turn_angle == -180)
					turn_angle = pick(-90.90)
				turn_mode--
				return TRUE
			else
				turn_mode--
		else if(turn_mode == 0)
			turn_mode--

	. = ..()

	if(.)

		if(item_contents >= 40)
			return .

		var/sucked = FALSE
		if(. && is_turf(loc))
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

	else if(ai.last_movement_proc == "cleaning") //failed.

		var/turf/T_right = get_step(src,turn(src.dir,-90))
		var/turf/T_left = get_step(src,turn(src.dir,90))

		if(!T_right || T_right.density || T_right.has_dense_atom)
			T_right = null

		if(!T_left || T_left.density || T_left.has_dense_atom)
			T_left = null

		if(T_right && T_left)
			turn_angle = -turn_angle
		else if(!T_right && !T_left)
			turn_angle = 180
		else if(T_right)
			turn_angle = -90
		else if(T_left)
			turn_angle = 90

		if(turn_mode > 0)
			turn_mode = 3
		else
			turn_mode = 3




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

	if(!qdeleting && next_sell >= world.time)

		var/total_value = 0
		for(var/obj/item/I in src.contents)
			if(I.loc != src)
				continue
			if(owner_ckey)
				total_value += I.get_value()
			qdel(I)
			CHECK_TICK_SAFE(50,FPS_SERVER)

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