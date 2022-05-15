/gamemode/nuke_ops/proc/swap_teams()

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

/gamemode/nuke_ops/proc/set_teams()

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

/gamemode/nuke_ops/proc/insert_latejoiners()

	for(var/k in teams["Ready"])
		var/join_NT = length(teams["NanoTrasen"]) < length(teams["Syndicate"])
		if(join_NT)
			move_to_team(k,"NanoTrasen")
		else
			move_to_team(k,"Syndicate")

/gamemode/nuke_ops/proc/give_loadout(var/mob/living/advanced/A)

	if(length(team_loadouts[A.loyalty_tag]))
		var/loadout/L = pick(team_loadouts[A.loyalty_tag])
		A.equip_loadout(L)
		return TRUE

	return FALSE

/gamemode/nuke_ops/proc/move_to_team(var/mob/living/L,var/desired_team)

	if(L.loyalty_tag && teams[L.loyalty_tag])
		teams[L.loyalty_tag] -= L

	if(desired_team && teams[desired_team])
		teams[desired_team] |= L
		L.loyalty_tag = desired_team
		L.iff_tag = desired_team

	return TRUE