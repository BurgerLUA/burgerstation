/virtual_reality/
	var/name
	var/desc
	var/list/active_players = list()

	var/base_loadout = /loadout/greytide

/virtual_reality/proc/on_player_join(var/mob/living/L) //What happens when a player joins virtual reality.
	active_players |= L
	if(base_loadout && is_advanced(L))
		var/mob/living/advanced/A = L
		A.equip_loadout(base_loadout)
	return TRUE

/virtual_reality/proc/on_player_leave(var/mob/living/L) //What happens when a player leaves virtual reality.
	active_players -= L
	return TRUE

/virtual_reality/proc/can_start()
	return TRUE

/virtual_reality/proc/start()
	return TRUE


/virtual_reality/team/
	var/list/teams = list()
	var/list/team_loadouts = list()

/virtual_reality/team/proc/move_to_team(var/mob/living/L,var/desired_team)

	if(L.loyalty_tag && teams[L.loyalty_tag])
		teams[L.loyalty_tag] -= L

	if(desired_team && teams[desired_team])
		teams[desired_team] |= L

	return TRUE

/virtual_reality/team/on_player_join(var/mob/living/L)
	. = ..()
	var/turf/T = pick(vr_lobby_spawnpoints)
	L.force_move(T)
	move_to_team(L,"Lobby")


/virtual_reality/team/on_player_leave(var/mob/living/L)
	. = ..()
	move_to_team(L,null)

