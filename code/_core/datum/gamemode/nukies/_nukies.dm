/gamemode/nuke_ops
	name = "Nuke Ops"

	// Config
	var/loadout/base_loadout = /loadout/virtual_reality //For joining players.
	var/list/team_loadouts = list(
		"Syndicate" = list(
			/loadout/virtual_reality/syndicate
		),
		"NanoTrasen" = list(
			/loadout/virtual_reality/nanotrasen
		),
		"Lobby" = list()
	)

	//Game Objects + Players
	var/obj/item/disk/nuke/tracked_disk
	var/obj/structure/interactive/nukies_nuke/tracked_nuke
	var/mob/living/active_players
	var/list/teams = list(
		"Syndicate" = list(),
		"NanoTrasen" = list(),
		"Lobby" = list(),
		"Ready" = list(),
		"Specatators" = list()
	)
	var/list/mob/living/advanced/needs_loadout = list() //List of players who need a loadout.

	var/obj/marker/syndicate_marker
	var/obj/marker/nanotrasen_marker
	var/obj/marker/objective_marker
	var/list/turf/valid_nanotrasen_turfs = list()
	var/list/turf/valid_syndicate_turfs = list()

	//Game data
	var/list/score = list(
		"NanoTrasen" = 0,
		"Syndicate" = 0
	)
	var/round = 0
	var/game_state = 1
	var/time_left = -1
	var/last_winner = 0

/gamemode/nuke_ops/proc/can_play_round()

	if(length(teams["Syndicate"]) <= 0)
		return FALSE

	if(length(teams["NanoTrasen"]) <= 0)
		return FALSE

	return TRUE


/gamemode/nuke_ops/proc/player_post_death(var/mob/living/advanced/player/virtual/P)
	. = ..()
	check_gamemode_win()

/gamemode/nuke_ops/proc/cleanup_map()
	QDEL_NULL(tracked_nuke)
	QDEL_NULL(tracked_disk)
	return TRUE

/gamemode/nuke_ops/proc/set_winner(var/desired_team)

	if(game_state == 6 || game_state == 7)
		return FALSE

	if(desired_team == "NanoTrasen")
		game_state = 6
		time_left = 10
		score["NanoTrasen"] += 1
		play_sound_global('sound/vr/nanotrasen_win.ogg',active_players)
		return TRUE
	if(desired_team == "Syndicate")
		game_state = 7
		time_left = 10
		score["Syndicate"] += 1
		play_sound_global('sound/vr/syndicate_win.ogg',active_players)
		return TRUE

	last_winner = desired_team

	return FALSE