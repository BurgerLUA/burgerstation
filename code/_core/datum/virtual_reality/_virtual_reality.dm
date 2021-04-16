/virtual_reality/
	var/name
	var/desc
	var/list/active_players = list()

	var/base_loadout = /loadout/greytide

	var/list/teams = list()
	var/list/team_loadouts = list()



/virtual_reality/proc/on_player_join(var/mob/living/L) //What happens when a player joins virtual reality.
	active_players |= L
	if(base_loadout && is_advanced(L))
		var/mob/living/advanced/A = L
		A.equip_loadout(base_loadout)
	var/turf/T = pick(vr_lobby_spawnpoints)
	L.force_move(T)
	move_to_team(L,"Lobby")
	return TRUE

/virtual_reality/proc/on_player_leave(var/mob/living/L) //What happens when a player leaves virtual reality.
	active_players -= L
	move_to_team(L,null)
	return TRUE

/virtual_reality/proc/can_start()
	return TRUE

/virtual_reality/proc/start()
	return TRUE

/virtual_reality/proc/on_life()
	return TRUE

/virtual_reality/proc/set_message(var/desired_message)

	for(var/mob/living/advanced/A in active_players)
		if(!A.client)
			continue
		for(var/obj/hud/button/message/M in A.buttons)
			M.set_text(desired_message)


/virtual_reality/proc/move_to_team(var/mob/living/L,var/desired_team)

	if(L.loyalty_tag && teams[L.loyalty_tag])
		teams[L.loyalty_tag] -= L

	if(desired_team && teams[desired_team])
		teams[desired_team] |= L
		L.loyalty_tag = desired_team
		L.iff_tag = desired_team

	return TRUE

/virtual_reality/proc/player_post_death(var/mob/living/advanced/player/virtual/P)
	return TRUE