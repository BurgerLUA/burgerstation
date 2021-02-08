/ai/ghost
	var/anger = 0
	var/hunt_duration = 0//Above 1 means hunt. Counts down by 1 every life tick.

	use_alerts = FALSE
	true_sight = TRUE
	use_cone_vision = FALSE
	should_investigate_alert = TRUE

	reaction_time = 0 //Instant

	var/mob/living/simple/ghost/owner_as_ghost

	var/ghost_type = "ghost"
	//shade
	//revenant
	//faithless
	//forgotten


	var/shy_level = 0
	//1 = will become more visible the more people around it.
	//2 = will become less visible the more people around it.
	//3 = will only show itself if people aren't looking at it.
	//On hunts, it's fully visible.

	var/stealth_killer = 0
	//1 = fully visible on hunt
	//2 = invisbile on hunt

	roaming_distance = 128

	var/origin_area_identifier

	var/talks = TRUE
	var/next_voice = 0

	var/was_being_watched = FALSE

	var/last_teleport = 0

/ai/ghost/handle_movement_roaming()

	if(was_being_watched)
		return FALSE

	return ..()

/ai/ghost/proc/setup_appearance()
	ghost_type = pick("shade","revenant","faithless","forgotten")
	owner_as_ghost.icon = 'icons/mob/living/simple/ghosts.dmi'
	owner_as_ghost.icon_state = ghost_type
	owner_as_ghost.name = ghost_type

/ai/ghost/New(var/mob/living/desired_owner)

	. = ..()

	var/turf/T = get_turf(desired_owner)
	var/area/A = T.loc
	origin_area_identifier = A.area_identifier

	owner_as_ghost = desired_owner
	shy_level = rand(1,3)
	//stealth_killer = rand(1,2)
	stealth_killer = 1

	setup_appearance()


	var/turf/T2 = find_new_location()
	if(T2)
		owner.force_move(T2)
		notify_ghosts("\The [owner.name] moved to [T2.loc.name].",T2)

	return .


/ai/ghost/proc/create_emf(var/turf/loc,var/desired_level=3,var/desired_range=VIEW_RANGE)

	if(!desired_level || !desired_range)
		return FALSE

	var/obj/emf/E = new(loc,desired_level,desired_range)
	INITIALIZE(E)
	GENERATE(E)
	FINALIZE(E)

	queue_delete(E,SECONDS_TO_DECISECONDS(20))

	return E

/ai/ghost/proc/find_new_location()

	var/list/possible_areas = SSarea.areas_by_identifier[origin_area_identifier]
	if(!length(possible_areas))
		return null

	var/chances_left = 5
	while(chances_left > 0)
		chances_left--
		var/area/A2 = pick(possible_areas)
		if(A2.allow_ghosts)
			continue
		var/turf/T = locate(A2.average_x,A2.average_y,A2.z)
		return T

	return null

/ai/ghost/on_life(var/tick_rate)

	anger = clamp(anger,0,200)

	var/turf/T = get_turf(owner)
	var/area/A = T.loc

	if(A.area_identifier != origin_area_identifier)
		var/turf/T2 = find_new_location()
		owner.force_move(T2)
		return TRUE

	if(owner.move_delay <= 0)
		//handle_movement_reset()
		handle_movement()

	if(owner.attack_next <= world.time)
		handle_attacking()

	owner.handle_movement(tick_rate)

	if(objective_attack || (anger >= 100 && last_teleport + SECONDS_TO_DECISECONDS(10) <= world.time))
		var/no_objective = !objective_attack
		objective_ticks += tick_rate
		owner_as_ghost.desired_alpha = stealth_killer == 2 ? 0 : 255
		if(objective_ticks >= get_objective_delay())
			objective_ticks = 0
			handle_objectives(tick_rate)
			if(objective_attack)
				anger -= DECISECONDS_TO_SECONDS(1)
				A.smash_all_lights() //This sleeps
				if(qdeleting || !owner || owner.qdeleting)
					return FALSE
				if(no_objective) //First time attacking.
					var/can_hunt = TRUE
					for(var/obj/item/cross/C in range(objective_attack,6))
						if(!C.broken)
							C.on_destruction(owner,TRUE)
							can_hunt = FALSE
							break
					if(can_hunt)
						anger = 200
						notify_ghosts("\The [owner.name] is now hunting!",T)
						owner.icon_state = "[ghost_type]_angry"
						play_sound('sound/ghost/ghost_ambience_2.ogg',T,volume=75)
					else
						set_objective(null)
						owner.icon_state = "[ghost_type]"
						anger = 50
			else
				owner.icon_state = "[ghost_type]"
				anger = 50
		return TRUE


	//Who is looking at us?
	var/list/viewers = list()
	var/mob/living/advanced/insane
	var/sanity_rating = 75
	if(T.lightness >= 0 && owner.invisibility < 101)
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

	//What should our alpha be?
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

	if(T.lightness >= 0.5) //Light bad.
		desired_alpha = 0
	else if (T.lightness <= 0)
		desired_alpha = 0

	//How should we respond to darkness?
	if(owner.alpha >= 0 && T.lightness >= 0.1 && prob(anger)) //Too bright
		desired_alpha -= 50
		if(anger >= 50)
			A.smash_all_lights()
			create_emf(T,4)
		else
			if(!A.toggle_all_lights())
				A.smash_all_lights()
				create_emf(T,4)
			else
				create_emf(T,3)
		var/annoying_player = FALSE
		var/tolerance = 0.75 - min(0.25,(anger/200))
		for(var/light_source/LS in T.affecting_lights)
			if(LS.light_power < tolerance)
				continue
			if(is_advanced(LS.top_atom))
				var/mob/living/advanced/ADV = LS.top_atom
				if(anger >= 50)
					if(talks && !annoying_player)
						play_sound(pick('sound/ghost/pain_1.ogg','sound/ghost/pain_2.ogg','sound/ghost/pain_3.ogg'),T,range_max=VIEW_RANGE)
						next_voice = world.time + SECONDS_TO_DECISECONDS(10)
					anger += 25
					ADV.sanity -= 50
				else
					anger += 10
					ADV.sanity -= 10
				annoying_player = TRUE
			if(istype(LS.source_atom,/obj/item/weapon/melee/torch))
				var/obj/item/weapon/melee/torch/L = LS.source_atom
				if(L.enabled) L.click_self(owner)
				create_emf(get_turf(L),3)
		if(annoying_player && last_teleport + SECONDS_TO_DECISECONDS(20) <= world.time)
			if(viewer_count >= 3)
				var/turf/T2 = find_new_location()
				if(T2)
					create_emf(T,2)
					owner.force_move(T2)
					create_emf(T2,3,VIEW_RANGE*3)
					notify_ghosts("\The [owner.name] moved to [T2.loc.name].",T2)
					if(talks)
						play_sound(pick('sound/ghost/over_here1.ogg','sound/ghost/over_here2.ogg'),T2,range_max=VIEW_RANGE)
						next_voice = world.time + SECONDS_TO_DECISECONDS(10)
					last_teleport = world.time
			else if(viewer_count || insane)
				var/mob/living/advanced/ADV = insane ? insane : pick(viewers)
				var/turf/T2 = get_turf(ADV)
				owner.force_move(T2)
				last_teleport = world.time
				if(talks)
					if(anger <= 50)
						play_sound(pick('sound/ghost/behind_you1.ogg','sound/ghost/behind_you2.ogg'),T2,range_max=VIEW_RANGE)
						next_voice = world.time + SECONDS_TO_DECISECONDS(10)
					else
						play_sound(pick('sound/ghost/turn_around1.ogg','sound/ghost/turn_around2.ogg'),T2,range_max=VIEW_RANGE)
						next_voice = world.time + SECONDS_TO_DECISECONDS(10)
				anger += 10


	//Look at the man who will die.
	if(insane)
		owner.set_dir(get_dir(owner,insane))
		if(talks && next_voice < world.time && prob(25))
			play_sound_target(pick('sound/ghost/i_see_you1.ogg','sound/ghost/i_see_you2.ogg','sound/ghost/im_here1.ogg','sound/ghost/im_here2.ogg'),insane)
			next_voice = world.time + SECONDS_TO_DECISECONDS(10)


	if(anger <= 10)
		desired_alpha = 0
	else if (anger >= 75)
		desired_alpha = 200


	desired_alpha = clamp(desired_alpha,0,255)
	owner_as_ghost.desired_alpha = desired_alpha

	was_being_watched = viewer_count > 0

	return TRUE


/ai/ghost/get_attack_score(var/mob/living/L)
	if(!is_advanced(L))
		return -1
	var/mob/living/advanced/A = L
	return 100 - A.sanity


/ai/ghost/set_alert_level(var/desired_alert_level,var/can_lower=FALSE,var/atom/alert_epicenter = null,var/atom/alert_source = null)
	//Trying to alert it just pisses it off.

	var/mob/living/advanced/A

	if(is_advanced(alert_source))
		A = alert_source

	switch(desired_alert_level)
		if(ALERT_LEVEL_NOISE)
			anger += 3
			A?.sanity -= 3
		if(ALERT_LEVEL_CAUTION)
			anger += 5
			A?.sanity -= 5
		if(ALERT_LEVEL_COMBAT)
			anger += 20
			A?.sanity -= 20


	return TRUE


/ai/ghost/shitass
	talks = FALSE

/ai/ghost/shitass/setup_appearance()
	ghost_type = "living"

	owner_as_ghost.icon = 'icons/mob/living/simple/shitass.dmi'
	owner_as_ghost.icon_state = "living"
	owner_as_ghost.name = "shitass"
