/ai/bot

/ai/bot/medical
	var/mob/living/healing_target
	var/damage_threshold = 20 //Value
	var/mob/living/simple/bot/medibot/owner_as_bot
	var/next_idle_voice = 0

	radius_find_enemy = 0
	should_investigate_alert = FALSE

	roaming_distance = 0

	resist_grabs = FALSE

/ai/bot/medical/New(var/desired_loc,var/mob/living/desired_owner)
	. = ..()
	next_idle_voice = world.time + rand(100,300)
	owner_as_bot = owner
	return .

/ai/bot/medical/Destroy()
	owner_as_bot = null
	healing_target = null
	return ..()

/ai/bot/medical/proc/is_valid_healing_target(var/mob/living/L)
	if(L == owner)
		return FALSE
	if(!L || L.qdeleting)
		return FALSE
	if(!istype(L.health) || !L.health.organic)
		return FALSE
	if(owner.loyalty_tag != L.loyalty_tag)
		return FALSE
	if(L.dead)
		return FALSE
	if(!owner_as_bot.get_inject_amount(L))
		return FALSE
	return TRUE

/ai/bot/medical/handle_objectives(var/tick_rate)

	if(!healing_target || !is_valid_healing_target(healing_target,get_dist(owner,healing_target),VIEW_RANGE))
		find_healing_target()

	if(healing_target && get_dist(healing_target,owner) <= 1 && !owner_as_bot.is_busy())
		owner_as_bot.try_treat(healing_target)

	return ..()

/ai/bot/medical/handle_movement()
	if(healing_target)
		if(get_dist(healing_target,owner) <= 1)
			owner.move_dir = 0x0
		else
			owner.move_dir = get_dir(owner,healing_target)
		return TRUE
	return ..()

/ai/bot/medical/proc/find_healing_target()

	var/mob/living/best_target = null
	var/best_distance = VIEW_RANGE

	if(next_idle_voice <= world.time)
		switch(rand(1,6))
			if(1)
				play_sound('sound/voice/medbot/apple.ogg',get_turf(owner),range_max=VIEW_RANGE)
				owner.do_say("An apple a day keeps me away!")
			if(2)
				play_sound('sound/voice/medbot/catch.ogg',get_turf(owner),range_max=VIEW_RANGE)
				owner.do_say("There's always a catch, and I'm the best there is.")
			if(3)
				play_sound('sound/voice/medbot/delicious.ogg',get_turf(owner),range_max=VIEW_RANGE)
				owner.do_say("Delicious!")
			if(4)
				play_sound('sound/voice/medbot/flies.ogg',get_turf(owner),range_max=VIEW_RANGE)
				owner.do_say("What kind of medbay is this? Everyone is dropping like flies!")
			if(5)
				play_sound('sound/voice/medbot/radar.ogg',get_turf(owner),range_max=VIEW_RANGE)
				owner.do_say("Radar! Put a mask on!")
			if(6)
				play_sound('sound/voice/medbot/surgeon.ogg',get_turf(owner),range_max=VIEW_RANGE)
				owner.do_say("I knew it, I should've been a plastic surgeon.")
		next_idle_voice = world.time + SECONDS_TO_DECISECONDS(120)

	for(var/mob/living/L in view(owner,8))
		if(!src.is_valid_healing_target(L))
			continue
		var/distance_check = get_dist(L,owner)
		if(distance_check >= best_distance)
			continue
		best_target = L
		best_distance = distance_check

	if(healing_target != best_target)
		healing_target = best_target
		if(healing_target)
			switch(rand(1,3))
				if(1)
					play_sound('sound/voice/medbot/injured.ogg',get_turf(owner),range_max=VIEW_RANGE)
					owner.do_say("You appear to be injured, [healing_target.name]!")
				if(2)
					play_sound('sound/voice/medbot/coming.ogg',get_turf(owner),range_max=VIEW_RANGE)
					owner.do_say("Hold on [healing_target.name], I'm coming!")
				if(3)
					play_sound('sound/voice/medbot/help.ogg',get_turf(owner),range_max=VIEW_RANGE)
					owner.do_say("Wait [healing_target.name], I want to help!")

	return TRUE



/ai/bot/medical/aggressive
	radius_find_enemy = VIEW_RANGE
	should_investigate_alert = TRUE
	roaming_distance = VIEW_RANGE
	resist_grabs = TRUE