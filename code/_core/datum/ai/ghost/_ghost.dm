/ai/ghost

	use_alerts = FALSE
	true_sight = TRUE
	use_cone_vision = FALSE
	should_investigate_alert = TRUE

	reaction_time = 0 //Instant

	var/mob/living/simple/ghost/owner_as_ghost

	var/ghost_type = "ghost" //This is the sprite and name. No effect on AI.

	var/anger = 0

	var/stat_player_limit = 1 //Amount of players it can tolerate. Numbers higher than this value can "calm" it.
	var/stat_anger_per_player = 0 //The amount of anger to add per player nearby. Supports negative numbers.
	var/stat_anger_per_player_viewing = 0 //The amount of anger to add per player lookinga t it. Supports negative numbers.
	var/stat_hunt_targets = 4 //The amount of targets it will track persistently at a time.
	var/stat_territorial = FALSE //Set to true if its anger is increased if a player is in their territory.
	var/stat_afraid_of_light = FALSE //Set to true if this ghost is pacified in the light.
	var/stat_vocal = FALSE //Set to true if this ghost talks a lot.
	var/stat_hates_noise = FALSE //set to true if it hates alert-causing things.

	var/list/directed_anger = list() //Ckey to number.

	roaming_distance = VIEW_RANGE

	var/origin_area_identifier
	var/area/origin_area

	var/next_voice = 0

	var/was_being_watched = FALSE

	var/last_teleport = 0
	var/last_hunt = 0

	active = TRUE

	var/next_star = 0

/ai/ghost/New(var/desired_loc,var/mob/living/desired_owner)

	. = ..()

	owner_as_ghost = desired_owner

	var/turf/T = get_turf(owner_as_ghost)
	var/area/A = T.loc
	origin_area_identifier = A.area_identifier

	stat_player_limit = prob(50) ? 1 : INFINITY
	stat_anger_per_player = prob(75) ? rand(1,5) : rand(0,-3)
	stat_anger_per_player_viewing = prob(75) ? rand(0,5) : rand(-1,5)
	stat_hunt_targets = prob(25) ? 0 : 5
	stat_territorial = prob(25)
	stat_afraid_of_light = prob(25)
	stat_vocal = prob(25)

	setup_appearance()


/ai/ghost/New()
	. = ..()
	var/turf/T2 = find_new_location()
	if(T2)
		owner.force_move(T2)
		notify_ghosts("A new [owner.name] was created at [T2.loc.name].",T2)
	else
		log_error("Tried creating a ghost ([owner.get_debug_name()]) in an invalid area!")
		qdel(owner)


/ai/ghost/proc/handle_ghost_pathing()

	if(objective_attack)
		var/turf/T1 = get_turf(owner)
		var/turf/T2 = get_turf(objective_attack)
		if(T1.z != T2.z || get_dist(T1,T2) > 64) //Too far, can't path.
			return FALSE
		var/astar_length = length(astar_path_current)
		if(astar_length)
			var/turf/T4 = get_turf(astar_path_current[astar_length]) //Check the end of the path.
			if(get_dist(T2,T4) >= 4 || next_star <= world.time) //Is it an old path?
				set_path_astar(T2)
				next_star = world.time + SECONDS_TO_DECISECONDS(4)
				return TRUE
		else
			var/move_dir = get_dir(T1,T2)
			var/turf/T3 = get_step(T1,move_dir)
			if(!T3.can_move_to(FALSE))
				set_path_astar(T2)
				next_star = world.time + SECONDS_TO_DECISECONDS(4)
				return TRUE

	else if(objective_move)
		var/turf/T1 = get_turf(owner)
		var/turf/T2 = get_turf(objective_move)
		if(T1.z != T2.z || get_dist(T1,T2) > 64) //Too far, can't path.
			return FALSE
		var/astar_length = length(astar_path_current)
		if(astar_length)
			var/turf/T4 = get_turf(astar_path_current[astar_length]) //Check the end of the path.
			if(get_dist(T2,T4) >= 4 || next_star <= world.time) //Is it an old path?
				set_path_astar(T2)
				next_star = world.time + SECONDS_TO_DECISECONDS(4)
				return TRUE
		else
			var/move_dir = get_dir(T1,T2)
			var/turf/T3 = get_step(T1,move_dir)
			if(!T3.can_move_to(FALSE))
				set_path_astar(T2)
				next_star = world.time + SECONDS_TO_DECISECONDS(4)
				return TRUE

	return FALSE



/ai/ghost/handle_movement()

	if(handle_movement_astar())
		last_movement_proc = "astar"
		return TRUE

	if(handle_movement_attack_objective())
		last_movement_proc = "attack_objective"
		return TRUE

	if(handle_movement_move_objective())
		last_movement_proc = "move_objective"
		return TRUE

	if(handle_movement_roaming())
		last_movement_proc = "roaming"
		return TRUE

	handle_movement_reset()

	last_movement_proc = "none"

	return FALSE


/*
/ai/ghost/handle_movement_roaming()

	if(was_being_watched && stat_anger_per_player_viewing < 0) //Likes attention. Don't roam around if players are watching.
		return FALSE

	. = ..()
*/

/ai/ghost/proc/setup_appearance()
	ghost_type = pick("shade","revenant","faithless","forgotten","clown","faceless")
	owner_as_ghost.icon = 'icons/mob/living/simple/ghosts.dmi'
	owner_as_ghost.icon_state = ghost_type
	owner_as_ghost.name = ghost_type

/ai/ghost/proc/create_emf(var/turf/loc,var/desired_level=3,var/desired_range=VIEW_RANGE)

	if(!desired_level || !desired_range)
		return FALSE

	var/obj/emf/E = new(loc,desired_level,desired_range)
	E.time_to_delete = world.time + SECONDS_TO_DECISECONDS(20)
	INITIALIZE(E)
	GENERATE(E)
	FINALIZE(E)

	return E

/ai/ghost/proc/find_new_location()

	var/list/possible_areas = SSarea.areas_by_identifier[origin_area_identifier].Copy()
	if(!length(possible_areas))
		return null

	var/chances_left = min(20,length(possible_areas))
	while(chances_left > 0)
		chances_left--
		var/area/A2 = pick(possible_areas)
		if(!A2.allow_ghost)
			possible_areas -= A2
			continue
		var/list/possible_turfs = list()
		for(var/turf/simulated/T in A2)
			if(!T.can_move_to())
				continue
			possible_turfs += T
		if(!length(possible_turfs))
			possible_areas -= A2
			continue
		return pick(possible_turfs)

	return null

/ai/ghost/on_life(var/tick_rate)

	anger = clamp(anger,0,200)

	var/turf/T = get_turf(owner)
	var/area/A = T.loc

	if(A.area_identifier != origin_area_identifier)
		var/turf/T2 = find_new_location()
		owner.force_move(T2)
		notify_ghosts("\The [owner.name] moved to [T2.loc.name].",T2)
		return TRUE

	if(owner.attack_next <= world.time)
		handle_attacking()

	if(owner.next_move <= 0)
		handle_ghost_pathing()
		handle_movement()

	owner.handle_movement(tick_rate)

	if(!CALLBACK_EXISTS("set_new_objective_\ref[src]") && (objective_attack || (anger >= 100 && last_teleport + SECONDS_TO_DECISECONDS(4) <= world.time)))
		var/no_objective = !objective_attack
		objective_ticks += tick_rate
		owner_as_ghost.desired_alpha = 255
		if(objective_ticks >= get_objective_delay())
			objective_ticks = 0
			if(objective_attack && frustration_attack < frustration_attack_threshold)
				handle_current_objectives(objective_delay)
			else
				find_new_objectives(objective_delay)
			if(objective_attack)
				anger -= 10 //Hunts for 200/10 seconds.
				if(qdeleting || !owner || owner.qdeleting)
					return FALSE
				if(no_objective) //First time attacking.
					var/can_hunt = TRUE
					for(var/obj/item/cross/C in range(objective_attack,6))
						if(!C.broken)
							C.on_destruction()
							can_hunt = FALSE
							break
					if(can_hunt)
						anger = 200
						notify_ghosts("\The [owner.name] is now hunting [objective_attack.name]!",T)
						owner.icon_state = "[ghost_type]_angry"
						play_sound('sound/ghost/ghost_ambience_2.ogg',T,volume=75)
					else
						notify_ghosts("\The [owner.name] stopped hunting.",T)
						set_objective(null)
						owner.icon_state = "[ghost_type]"
						anger = 50
				A.smash_all_lights() //This sleeps
			else
				owner.icon_state = "[ghost_type]"
				anger = 50
		owner_as_ghost.desired_alpha = 255
		return TRUE

	//Who is looking at us?
	var/list/found_viewers = list()
	var/list/found_proximity = list()
	var/mob/living/advanced/insane
	var/anger_rating = 25
	if(T.lightness >= 0 && owner.invisibility < 101 && owner.alpha >= 100)
		for(var/mob/living/advanced/ADV in viewers(VIEW_RANGE,owner))
			if(ADV.dead)
				continue
			if(!ADV.client)
				continue
			found_proximity += ADV
			add_anger(ADV.ckey,stat_anger_per_player)
			if(!(ADV.dir & get_dir(ADV,owner)))
				continue
			found_viewers += ADV
			add_anger(ADV.ckey,stat_anger_per_player_viewing)
			if(directed_anger[ADV.ckey] >= anger_rating)
				insane = ADV
				anger_rating = directed_anger[ADV.ckey]

	var/proximity_count = length(found_proximity)
	var/viewer_count = length(found_viewers)

	anger += min(1,proximity_count) + min(1,viewer_count)

	if(stat_anger_per_player)
		for(var/k in found_proximity)
			var/mob/living/L = k
			add_anger(L.ckey,-stat_anger_per_player)
	if(stat_anger_per_player_viewing)
		for(var/k in found_viewers)
			var/mob/living/L = k
			add_anger(L.ckey,-stat_anger_per_player_viewing)

	//How should we respond to light?
	var/desired_alpha = 255
	if(stat_afraid_of_light)
		if(T.lightness >= 0.25) //Light bad.
			desired_alpha = 100
		else
			desired_alpha = 255
	else
		if(T.lightness >= 0.25)
			desired_alpha = 200
		else
			desired_alpha = 100

	//How should we respond to viewers?
	if(proximity_count*stat_anger_per_player + viewer_count*stat_anger_per_player_viewing > 0)
		desired_alpha *= 0.75
	else
		desired_alpha *= 1.25

	//How should we respond to light? PT2
	if(T.lightness >= 0.1) //Too bright. Even if we're fine with light, we're pissed.
		desired_alpha -= 50
		if(prob(anger))
			if(anger >= 50)
				A.smash_all_lights()
				create_emf(T,4)
			else
				if(!(A.enable_power_lights & ON))
					A.smash_all_lights()
					create_emf(T,4)
				else
					A.toggle_power_lights(OFF | (A.enable_power_lights & AUTO))
					create_emf(T,3)
		if(stat_afraid_of_light)
			var/annoying_player = FALSE
			var/tolerance = 0.75 - min(0.25,(anger/200))
			for(var/light_source/LS in T.affecting_lights)
				if(LS.light_power < tolerance)
					continue
				if(is_advanced(LS.top_atom))
					var/mob/living/advanced/ADV = LS.top_atom
					if(anger >= 50)
						if(stat_vocal && !annoying_player)
							play_sound(pick('sound/ghost/pain_1.ogg','sound/ghost/pain_2.ogg','sound/ghost/pain_3.ogg'),T,range_max=VIEW_RANGE)
							next_voice = world.time + SECONDS_TO_DECISECONDS(10)
						add_anger(ADV.ckey,20)
					else
						add_anger(ADV.ckey,10)
					annoying_player = TRUE
				if(istype(LS.source_atom,/obj/item/weapon/melee/torch))
					var/obj/item/weapon/melee/torch/L = LS.source_atom
					if(L.enabled) L.click_self(owner)
					create_emf(get_turf(L),3)
			if(annoying_player && last_teleport + SECONDS_TO_DECISECONDS(60) <= world.time)
				if(viewer_count || insane)
					var/mob/living/advanced/ADV = insane ? insane : pick(found_viewers)
					var/turf/T2 = get_turf(ADV)
					owner.force_move(T2)
					last_teleport = world.time
					if(stat_vocal)
						if(anger <= 50)
							play_sound(pick('sound/ghost/behind_you1.ogg','sound/ghost/behind_you2.ogg'),T2,range_max=VIEW_RANGE)
							next_voice = world.time + SECONDS_TO_DECISECONDS(10)
						else
							play_sound(pick('sound/ghost/turn_around1.ogg','sound/ghost/turn_around2.ogg'),T2,range_max=VIEW_RANGE)
							next_voice = world.time + SECONDS_TO_DECISECONDS(10)
					add_anger(ADV.ckey,10)

	//Look at the man who will die.
	if(insane)
		owner.set_dir(get_dir(owner,insane))
		if(stat_vocal && next_voice < world.time && prob(25))
			play_sound_target(pick('sound/ghost/i_see_you1.ogg','sound/ghost/i_see_you2.ogg','sound/ghost/im_here1.ogg','sound/ghost/im_here2.ogg'),insane)
			next_voice = world.time + SECONDS_TO_DECISECONDS(10)

	if(anger <= 50)
		desired_alpha = 0 //No reason to show ourselves.
	else if (anger >= 75)
		desired_alpha = 255 //Ok you're pissing me off.

	desired_alpha = clamp(desired_alpha,0,255)
	owner_as_ghost.desired_alpha = desired_alpha
	owner_as_ghost.mouse_opacity = desired_alpha <= 100 ? 0 : 1

	was_being_watched = viewer_count > 0

	if(!objective_move && prob(5))
		var/list/possible_turfs = list()
		if(origin_area && prob(10))
			for(var/turf/simulated/floor/TF in origin_area)
				if(!TF.can_move_to(FALSE))
					continue
				possible_turfs += TF
		else
			for(var/turf/simulated/floor/TF in range(owner,VIEW_RANGE))
				var/area/AF = TF.loc
				if(AF.area_identifier != origin_area_identifier)
					continue
				if(!AF.allow_ghost)
					continue
				if(!TF.can_move_to(FALSE))
					continue
				possible_turfs += TF
		if(length(possible_turfs))
			set_move_objective(pick(possible_turfs))

	return TRUE

/ai/ghost/get_attack_score(var/mob/living/L)
	if(!is_advanced(L))
		return -100
	return L.ckey && directed_anger[L.ckey] ? directed_anger[L.ckey] : 1

/ai/ghost/proc/add_anger(var/ckey,var/amount)
	if(!amount)
		return TRUE
	if(ckey)
		if(!directed_anger[ckey])
			directed_anger[ckey] = amount
		else
			directed_anger[ckey] += amount
	anger += amount
	return TRUE

/ai/ghost/set_alert_level(var/desired_alert_level,var/atom/alert_source,var/atom/alert_epicenter,var/can_lower=FALSE)
	//Trying to alert it just pisses it off.

	if(!stat_hates_noise)
		return TRUE

	if(is_advanced(alert_source))
		var/mob/living/advanced/A = alert_source
		switch(desired_alert_level)
			if(ALERT_LEVEL_NOISE)
				add_anger(A.ckey,5)
			if(ALERT_LEVEL_CAUTION)
				add_anger(A.ckey,10)
			if(ALERT_LEVEL_COMBAT)
				add_anger(A.ckey,20)

	return TRUE


/ai/ghost/shitass/New(var/desired_loc,var/mob/living/desired_owner)
	. = ..()
	stat_vocal = FALSE

/ai/ghost/shitass/setup_appearance()
	ghost_type = "living"
	owner_as_ghost.icon = 'icons/mob/living/simple/shitass.dmi'
	owner_as_ghost.icon_state = "living"
	owner_as_ghost.name = "shitass"


/ai/ghost/post_move(var/mob/living/L,args)
	. = ..()
	if(. && prob(10))
		var/list/valid_objects = list()
		for(var/obj/O in view(2,owner))
			valid_objects += O
		while(length(valid_objects))
			var/obj/O = pick(valid_objects)
			if(!owner.click_on_object(owner,O,null,null,null))
				valid_objects -= O
				continue