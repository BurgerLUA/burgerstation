SUBSYSTEM_DEF(gamemode)
	name = "Gamemode Subsystem"
	desc = "Stores all the known gamemodes and triggers a vote for the gamemode when the game starts."
	priority = SS_ORDER_PRELOAD
	tick_rate = SECONDS_TO_TICKS(1)

	var/list/all_gamemodes = list()
	var/gamemode/active_gamemode
	var/gamemode_state = GAMEMODE_INITIALIZING

	var/round_time = 0 //In seconds.
	var/round_time_next = -1

/subsystem/gamemode/Initialize()

	for(var/k in subtypesof(/gamemode/))
		var/gamemode/G = new k
		all_gamemodes[G.type] = G

	log_subsystem(name,"Initialized [length(all_gamemodes)] gamemodes.")

	return ..()

/subsystem/gamemode/PostInitialize()
	. = ..()
	gamemode_state = GAMEMODE_SETUP
	return .

/subsystem/gamemode/on_life()
	if(active_gamemode)
		active_gamemode.on_life()
	round_time++
	return ..()