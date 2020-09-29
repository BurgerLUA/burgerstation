/ai/bot

/ai/bot/medical
	var/mob/living/healing_target
	var/damage_threshold = 20 //Value
	var/mob/living/simple/bot/medical/owner_as_bot
	var/next_idle_voice = 0

	radius_find_enemy = 0
	should_investigate_alert = FALSE

	roaming_distance = 0

	resist_grabs = FALSE

/ai/bot/medical/New(var/mob/living/desired_owner)
	. = ..()
	next_idle_voice = world.time + rand(100,300)
	owner_as_bot = owner
	return .

/ai/bot/medical/Destroy()
	owner_as_bot = null
	healing_target = null
	return ..()

/ai/bot/medical/proc/is_valid_healing_target(var/mob/living/L,var/distance_check=VIEW_RANGE,var/best_distance=VIEW_RANGE*2)
	if(L == owner)
		return FALSE
	if(!L || L.qdeleting)
		return FALSE
	if(L.loyalty_tag != L.loyalty_tag)
		return FALSE
	if(L.dead)
		return FALSE
	if(distance_check >= best_distance)
		return FALSE
	if(!L.reagents)
		return FALSE
	if(L.reagents.stored_reagents[owner_as_bot.reagent_to_inject])
		return FALSE
	if(!L.health || ((L.health.health_max - L.health.health_current) < damage_threshold))
		return FALSE
	return TRUE

/ai/bot/medical/handle_objectives()

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

	var/mob/living/best_target
	var/best_distance

	if(next_idle_voice <= world.time)
		switch(rand(1,6))
			if(1)
				play('sound/voice/medbot/apple.ogg',get_turf(owner))
				owner.say("An apple a day keeps me away!")
			if(2)
				play('sound/voice/medbot/apple.ogg',get_turf(owner))
				owner.say("There's always a catch, and I'm the best there is.")
			if(3)
				play('sound/voice/medbot/delicious.ogg',get_turf(owner))
				owner.say("Delicious!")
			if(4)
				play('sound/voice/medbot/flies.ogg',get_turf(owner))
				owner.say("What kind of medbay is this? Everyone is dropping like flies!")
			if(5)
				play('sound/voice/medbot/radar.ogg',get_turf(owner))
				owner.say("Radar! Put a mask on!")
			if(6)
				play('sound/voice/medbot/surgeon.ogg',get_turf(owner))
				owner.say("I knew it, I should've been a plastic surgeon.")
		next_idle_voice = world.time + SECONDS_TO_DECISECONDS(120)

	for(var/mob/living/L in view(owner,8))
		var/distance_check = get_dist(L,owner)
		if(!src.is_valid_healing_target(L,distance_check,best_distance))
			continue
		best_target = L
		best_distance = distance_check

	if(healing_target != best_target)
		healing_target = best_target
		if(healing_target)
			switch(rand(1,3))
				if(1)
					play('sound/voice/medbot/injured.ogg',get_turf(owner))
					owner.say("You appear to be injured, [healing_target.name]!")
				if(2)
					play('sound/voice/medbot/coming.ogg',get_turf(owner))
					owner.say("Hold on [healing_target.name], I'm coming!")
				if(3)
					play('sound/voice/medbot/help.ogg',get_turf(owner))
					owner.say("Wait [healing_target.name], I want to help!")

