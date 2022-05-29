/gamemode/nuke_ops/proc/setup_player(var/mob/living/L,var/turf/T)
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

	return TRUE

/gamemode/nuke_ops/proc/on_player_join(var/mob/living/L) //What happens when a player joins
	active_players |= L
	if(base_loadout && is_advanced(L))
		var/mob/living/advanced/A = L
		A.equip_loadout(base_loadout)
	var/turf/T = pick(vr_lobby_spawnpoints)
	L.force_move(T)
	move_to_team(L,"Lobby")
	return TRUE

/gamemode/nuke_ops/proc/set_message(var/desired_message) //TODO: Make this better.

	for(var/mob/living/advanced/A in active_players)
		if(!A.client)
			continue
		for(var/obj/hud/button/message/M in A.buttons)
			M.set_text(desired_message)


/gamemode/nuke_ops/proc/on_player_leave(var/mob/living/L) //What happens when a player leaves virtual reality.
	active_players -= L
	move_to_team(L,null)
	return TRUE

/gamemode/nuke_ops/proc/setup_markers()

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

/gamemode/nuke_ops/proc/setup_spawnpoints()

	CREATE(/obj/structure/interactive/vr_shop,syndicate_marker)
	var/turf/nuke_loc = get_step(syndicate_marker,WEST)
	tracked_nuke = CREATE(/obj/structure/interactive/nukies_nuke,nuke_loc)

	CREATE(/obj/structure/interactive/vr_shop,nanotrasen_marker)
	var/turf/disk_loc = get_step(nanotrasen_marker,WEST)
	tracked_disk = CREATE(/obj/item/disk/nuke,disk_loc)

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

	return TRUE