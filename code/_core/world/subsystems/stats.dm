/SUBSYSTEM_DEF(stats)
	name = "Stats"
	desc = "Tracks stats and other records for the round and game."
	priority = SS_ORDER_PRELOAD

	var/nanotrasen_kills = 0
	var/nanotrasen_deaths = 0

	var/antag_kills = 0
	var/antag_deaths = 0

	var/other_kills = 0
	var/other_deaths = 0

	var/list/first_player_death = list(
		"attacker" = "no one",
		"victim" = "no one",
		"weapon" = "nothing",
		"last_words" = "none"
	)

	var/list/highest_damage = list(
		"attacker" = "no one",
		"victim" = "no one",
		"weapon" = "nothing",
		"damage" = 0
	)

/subsystem/stats/Initialize()


	return ..()