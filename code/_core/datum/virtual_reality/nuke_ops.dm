/virtual_reality/team/nuke_ops
	name = "Nuke Ops"
	desc = "NanoTrasen defends Syndicate from planting a bomb."

	teams = list(
		"Syndicate" = list(),
		"NanoTrasen" = list(),
		"Lobby" = list(),
		"Ready" = list(),
		"Specatators" = list()
	)

	team_loadouts = list(
		"Syndicate" = list(
			/loadout/virtual_reality/syndicate
		),
		"NanoTrasen" = list(
			/loadout/virtual_reality/nanotrasen
		),
		"Lobby" = list()
	)


	var/list/needs_loadout = list()

	var/list/valid_syndicate_turfs = list()
	var/list/valid_nanotrasen_turfs = list()

	var/turf/syndicate_marker
	var/turf/nanotrasen_marker
	var/turf/objective_marker

	var/last_winner

	var/round = 0 //Every 5 rounds is a team swap..

	var/state = 1

	var/list/score = list(
		"NanoTrasen" = 0,
		"Syndicate" = 0
	)

	//1 = waiting for players
	//2 = starting game
	//3 = starting round
	//4 = buy period
	//5 = action peroid
	//6 = round ending, NanoTrasen victory
	//7 = round nding, Syndicate victory
	//8 = overtime

	var/time_left = -1

	var/list/obj/item/disk/nuke/tracked_nuke_disks = list()

	var/obj/structure/interactive/vr_nuke/tracked_nuke

	var/list/obj/effect/fog_of_war/tracked_fogs = list()

/virtual_reality/team/nuke_ops/proc/on_kill_player(var/mob/living/advanced/player/owner,args)
	owner.adjust_currency(1000)
	return TRUE

/virtual_reality/team/nuke_ops/on_player_join(var/mob/living/L) //What happens when a player joins virtual reality.
	. = ..()
	if(is_player(L))
		HOOK_ADD("on_kill_player","\ref[L]_on_kill_player",L,src,.proc/on_kill_player)

/virtual_reality/team/nuke_ops/on_player_leave(var/mob/living/L) //What happens when a player leaves virtual reality.
	. = ..()
	if(is_player(L))
		HOOK_REMOVE("on_kill_player","\ref[L]_on_kill_player",L)

/virtual_reality/team/nuke_ops/proc/give_loadout(var/mob/living/advanced/A)

	if(length(team_loadouts[A.loyalty_tag]))
		var/loadout/L = pick(team_loadouts[A.loyalty_tag])
		A.equip_loadout(L)


/virtual_reality/team/nuke_ops/proc/can_play_round()

	if(length(teams["Syndicate"]) <= 0)
		return FALSE

	if(length(teams["NanoTrasen"]) <= 0)
		return FALSE

	return TRUE

/virtual_reality/team/nuke_ops/proc/cleanup_map()

	QDEL_NULL(tracked_nuke)

	for(var/k in tracked_nuke_disks)
		tracked_nuke_disks -= k
		var/obj/item/I = k
		qdel(I)

/virtual_reality/team/nuke_ops/proc/setup_player(var/mob/living/L,var/turf/T)
	L.force_move(T)
	L.rejuvenate()
	if(L.client)
		L.client.spectate(null)
	if(is_player(L))
		var/mob/living/advanced/player/P = L
		if(needs_loadout[L])
			P.adjust_currency(500-P.currency)
		else
			var/currency_to_give = 0
			if(last_winner == P.loyalty_tag)
				currency_to_give += 2000
			else
				currency_to_give += 4000
			if(P.dead)
				currency_to_give += 1000
			else
				currency_to_give += 1500
			if(currency_to_give)
				P.adjust_currency(currency_to_give)
	if(L.dead)
		L.revive()
		if(is_advanced(L))
			var/mob/living/advanced/A = L
			A.strip_and_delete_items()
			give_loadout(A)
	else if(needs_loadout[L] && is_advanced(L))
		var/mob/living/advanced/A = L
		A.strip_and_delete_items()
		give_loadout(A)
	needs_loadout -= L
	L.add_status_effect(PARALYZE,SECONDS_TO_DECISECONDS(15),SECONDS_TO_DECISECONDS(15),stealthy=TRUE,bypass_limits=TRUE)
	if(L.loyalty_tag == "Syndicate" && is_advanced(L))
		var/obj/item/disk/nuke/ND = CREATE(/obj/item/disk/nuke,get_turf(L))
		ND.quick_equip(L)
		tracked_nuke_disks += ND


	return TRUE

/virtual_reality/team/nuke_ops/proc/place_mobs_at_spawn()

	for(var/k in teams["NanoTrasen"])
		var/mob/living/L = k
		var/turf/T = pick(valid_nanotrasen_turfs)
		if(length(valid_nanotrasen_turfs) > 4)
			valid_nanotrasen_turfs -= T
		setup_player(L,T)

	for(var/k in teams["Syndicate"])
		var/mob/living/L = k
		var/turf/T = pick(valid_syndicate_turfs)
		if(length(valid_syndicate_turfs) > 4)
			valid_syndicate_turfs -= T
		setup_player(L,T)


/virtual_reality/team/nuke_ops/move_to_team(var/mob/living/L,var/desired_team)

	. = ..()

	if(. && is_advanced(L) && team_loadouts[desired_team])
		needs_loadout[L] = TRUE

/virtual_reality/team/nuke_ops/proc/generate_spawnpoints()

	CREATE(/obj/structure/interactive/vr_shop,syndicate_marker)
	var/turf/nuke_loc = get_step(syndicate_marker,WEST)
	tracked_nuke = CREATE(/obj/structure/interactive/vr_nuke,nuke_loc)

	CREATE(/obj/structure/interactive/vr_shop,nanotrasen_marker)

	tracked_nuke.nuke_area = get_area(objective_marker)

	valid_syndicate_turfs = list()
	for(var/turf/simulated/floor/F in view(VIEW_RANGE*0.5,syndicate_marker))
		if(!F.is_safe_teleport())
			continue
		valid_syndicate_turfs += F

	valid_nanotrasen_turfs = list()
	for(var/turf/simulated/floor/F in view(VIEW_RANGE*0.5,nanotrasen_marker))
		if(!F.is_safe_teleport())
			continue
		valid_nanotrasen_turfs += F

/virtual_reality/team/nuke_ops/proc/insert_latejoiners()

	for(var/k in teams["Ready"])
		var/join_NT = length(teams["NanoTrasen"]) < length(teams["Syndicate"])
		if(join_NT)
			move_to_team(k,"NanoTrasen")
		else
			move_to_team(k,"Syndicate")

/virtual_reality/team/nuke_ops/proc/round_start()
	state = 2
	log_debug("Setting VR state to 2 due to round_start()")
	cleanup_map()
	set_markers()
	generate_spawnpoints()
	if(round == 0)
		set_teams()
	else
		if(!(round % 5))
			swap_teams()
		if(!(round % 10))
			SSvote.create_vote(/vote/continue_round)

	insert_latejoiners()

	place_mobs_at_spawn()

	round++
	state = 3
	log_debug("Setting VR state to 3 due to round_start()")
	time_left = 5 //Seconds

/virtual_reality/team/nuke_ops/proc/set_markers()

	var/list/valid_spawnpoints = tdm_spawnpoints.Copy()

	syndicate_marker = pick(valid_spawnpoints)
	valid_spawnpoints -= syndicate_marker

	nanotrasen_marker = null
	var/best_distance = 0
	for(var/k in valid_spawnpoints)
		var/turf/T = k
		var/distance = get_dist(T,syndicate_marker)
		if(!nanotrasen_marker || best_distance < distance)
			nanotrasen_marker = T
			best_distance = distance
	valid_spawnpoints -= nanotrasen_marker

	objective_marker = null
	best_distance = INFINITY
	for(var/k in valid_spawnpoints)
		var/turf/T = k
		var/distance_diff = abs(get_dist(T,syndicate_marker) - get_dist(T,nanotrasen_marker))
		if(!objective_marker || distance_diff < best_distance)
			objective_marker = T
			best_distance = distance_diff

	return TRUE

/virtual_reality/team/nuke_ops/proc/set_teams()

	var/n_count = 0
	var/s_count = 0

	var/i=1 + prob(50)
	for(var/k in teams["Ready"])
		var/mob/living/L = k
		if(i % 2)
			move_to_team(L,"NanoTrasen")
			n_count++
		else
			move_to_team(L,"Syndicate")
			s_count++
		i++

	log_debug("Made [n_count] players NanoTrasen.")
	log_debug("Made [s_count] players Syndicate.")



/virtual_reality/team/nuke_ops/proc/swap_teams()

	last_winner = null

	score = list(
		"NanoTrasen" = 0,
		"Syndicate" = 0
	)

	var/list/syndicate_members = teams["Syndicate"].Copy()
	var/list/nanotrasen_members = teams["NanoTrasen"].Copy()

	for(var/k in syndicate_members)
		move_to_team(k,"NanoTrasen")

	for(var/k in nanotrasen_members)
		move_to_team(k,"Syndicate")

	play_sound_global('sound/vr/team_switch.ogg',active_players)

	return TRUE

/virtual_reality/team/nuke_ops/on_life()

	if(time_left > 0)
		time_left--

	if(state != 1 && length(active_players) <= 0)
		score = list(
				"NanoTrasen" = 0,
				"Syndicate" = 0
		)
		round = 0
		state = 1
		time_left = -1
		return ..()

	switch(state)
		if(0)
			set_message("Setting up game...")
		if(1)
			if(time_left >= 0)
				set_message("Game starts in [get_clock_time(time_left)] ([length(teams["Ready"])] players ready).")
			else
				set_message("Waiting for players ([length(teams["Ready"])]/1 ready)...")
		if(2)
			set_message("Starting game...")
		if(3)
			set_message("Round starts in [get_clock_time(time_left)].")
		if(4)
			set_message("Buy period: [get_clock_time(time_left)].")
		if(5)
			set_message("NanoTrasen: [score["NanoTrasen"]] | [get_clock_time(time_left)] | Syndicate: [score["Syndicate"]].")
		if(6)
			set_message("NanoTrasen wins!")
		if(7)
			set_message("Syndicate wins!")
		if(8)
			set_message("OVERTIME")


	if(state == 1)
		if(length(teams["Ready"]) >= 1)
			if(time_left == -1) time_left = 60
		else
			if(time_left != -1) time_left = -1
		if(time_left == 0)
			round_start()
			return ..()

	if(time_left <= 0)
		switch(state)
			if(3)
				time_left = 10
				state = 4
				play_sound_global('sound/vr/round_start.ogg',active_players)
			if(4)
				time_left = 600
				state = 5
				//play_sound_global('sound/vr/syndicate_objectives.ogg',teams["Syndicate"])
				//play_sound_global('sound/vr/nanotrasen_objectives.ogg',teams["NanoTrasen"])
			if(5)
				if(tracked_nuke && tracked_nuke.state == 2)
					state = 8 //Overtime.
					time_left = 0
					play_sound_global('sound/vr/overtime.ogg',active_players)
				else
					set_winner("NanoTrasen")
			if(6 to 7)
				round_start()

	if(state == 5 && !can_play_round())
		for(var/k in active_players)
			var/mob/M = k
			M.to_chat(span("danger","Not enough players on one team, returning to lobby."))
			on_player_join(M)
		score = list(
				"NanoTrasen" = 0,
				"Syndicate" = 0
		)
		round = 0
		state = 1
		time_left = -1

	. = ..()

/virtual_reality/team/nuke_ops/proc/set_winner(var/desired_team)

	if(state == 6 || state == 7)
		return FALSE

	if(desired_team == "NanoTrasen")
		state = 6
		time_left = 10
		score["NanoTrasen"] += 1
		play_sound_global('sound/vr/nanotrasen_win.ogg',active_players)
		return TRUE
	if(desired_team == "Syndicate")
		state = 7
		time_left = 10
		score["Syndicate"] += 1
		play_sound_global('sound/vr/syndicate_win.ogg',active_players)
		return TRUE

	last_winner = desired_team

	return FALSE

/virtual_reality/team/nuke_ops/proc/check_gamemode_win()

	if(state >= 6)
		return FALSE

	if(tracked_nuke.state >= 2)
		if(tracked_nuke.state == 4)
			set_winner("Syndicate")
			return TRUE
		else if(tracked_nuke.state == 3)
			set_winner("NanoTrasen")
			return TRUE
		return FALSE

	if(length(teams["NanoTrasen"]) <= 0)
		set_winner("Syndicate")
		return TRUE
	else if(length(teams["Syndicate"]) <= 0)
		set_winner("NanoTrasen")
		return TRUE

	var/nt_count = 0
	for(var/k in teams["NanoTrasen"])
		var/mob/living/L = k
		if(!L.dead)
			nt_count++
	if(nt_count <= 0)
		set_winner("Syndicate")
		return TRUE

	var/syn_count = 0
	for(var/k in teams["Syndicate"])
		var/mob/living/L = k
		if(!L.dead)
			syn_count++
	if(syn_count <= 0)
		set_winner("NanoTrasen")
		return TRUE


/virtual_reality/team/nuke_ops/player_post_death(var/mob/living/advanced/player/virtual/P)
	. = ..()
	check_gamemode_win()