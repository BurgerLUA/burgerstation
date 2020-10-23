/ai/ghost
	var/anger = 0
	var/hunt_duration = 0//Above 1 means hunt. Counts down by 1 every life tick.

	use_alerts = FALSE
	true_sight = TRUE
	use_cone_vision = FALSE
	should_investigate_alert = TRUE

	reaction_time = 0 //Instant

	var/mob/living/simple/npc/ghost/owner_as_ghost

	var/shy_level = 0
	//1 = will become more visible the more people around it.
	//2 = will become less visible the more people around it.
	//3 = will only show itself if people aren't looking at it.
	//On hunts, it's fully visible.

	roaming_distance = 0

/ai/ghost/New(var/mob/living/desired_owner)
	. = ..()
	owner_as_ghost = desired_owner
	shy_level = rand(1,3)
	return .

/ai/ghost/on_life(var/tick_rate=AI_TICK)

	world.log << "Anger: [anger]."

	var/turf/T = get_turf(owner)
	var/area/A = T.loc

	if(owner.move_delay <= 0)
		handle_movement_reset()
		handle_movement()

	owner.handle_movement(tick_rate)

	if(anger >= 100)
		log_debug("\The [owner.name] is ANGRY!")
		var/no_objective = !objective_attack
		anger = 200
		objective_ticks += tick_rate
		if(objective_ticks >= get_objective_delay())
			objective_ticks = 0
			handle_objectives()
			if(objective_attack)
				anger -= DECISECONDS_TO_SECONDS(1)
				if(no_objective)
					animate(owner,alpha=255,time=1)
					notify_ghosts("\The [owner.name] is now hunting!",T)
					log_debug("\The [owner.name] is now hunting!")
			else
				anger = 50
		return TRUE


	//Who is looking at us?
	var/list/viewers = list()
	var/mob/living/advanced/insane
	var/sanity_rating = 9999

	if(T.darkness >= 0 && owner.invisibility < 101)
		for(var/mob/living/advanced/ADV in view(owner,owner.view))
			if(ADV.dead)
				continue
			if(!ADV.client)
				continue
			if(!(ADV.dir & get_dir(ADV,owner)))
				continue
			viewers += ADV
			ADV.sanity -= DECISECONDS_TO_SECONDS(2)
			if(ADV.sanity < sanity_rating)
				insane = ADV
				sanity_rating = ADV.sanity

	var/viewer_count = length(viewers)

	var/desired_alpha = 200

	switch(shy_level)
		if(2) //Shy
			anger += viewer_count*0.05
			desired_alpha -= viewer_count ? 50 : 0
		if(3) //Super shy
			if(!viewer_count)
				anger -= 0.03
			else
				anger += viewer_count*0.15
			desired_alpha -= viewer_count ? 150 : 50

	if(T.darkness >= 0.5) //Light bad.
		desired_alpha = 0

	if(T.darkness >= 0.1 && prob(anger)) //Too bright
		desired_alpha -= 50
		if(anger >= 50)
			A.smash_all_lights()
		else
			A.toggle_all_lights()
		for(var/light_source/LS in T.affecting_lights)
			if(is_advanced(LS.top_atom))
				var/mob/living/advanced/ADV = LS.top_atom
				anger += 10
				ADV.sanity -= 25
				play(pick('sound/ghost/pain_1.ogg','sound/ghost/pain_2.ogg','sound/ghost/pain_3.ogg'),ADV)
			if(istype(LS.source_atom,/obj/item/weapon/melee/torch))
				var/obj/item/weapon/melee/torch/L = LS.source_atom
				if(L.enabled) L.click_self(owner)

	//Look at the man who will die.
	if(insane) owner.set_dir(get_dir(owner,insane))

	owner_as_ghost.desired_alpha = desired_alpha

	return TRUE


/ai/ghost/get_attack_score(var/mob/living/L)
	if(!is_advanced(L))
		return -1
	var/mob/living/advanced/A = L
	return 100 - A.sanity


/ai/ghost/set_alert_level(var/desired_alert_level,var/can_lower=FALSE,var/atom/alert_epicenter = null,var/atom/alert_source = null)
	//Trying to alert it just pisses it off.
	switch(desired_alert_level)
		if(ALERT_LEVEL_NOISE)
			anger += 3
		if(ALERT_LEVEL_CAUTION)
			anger += 5
		if(ALERT_LEVEL_COMBAT)
			anger += 20

	return TRUE