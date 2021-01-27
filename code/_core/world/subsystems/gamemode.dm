SUBSYSTEM_DEF(gamemode)
	name = "Gamemode Subsystem"
	desc = "Stores all the known gamemodes and triggers a vote for the gamemode when the game starts."
	priority = SS_ORDER_LAST
	tick_rate = SECONDS_TO_TICKS(1)

	var/list/all_gamemodes = list()
	var/gamemode/active_gamemode

/subsystem/gamemode/proc/set_active_gamemode(var/gamemode/desired_gamemode,var/source)
	QDEL_NULL(active_gamemode)
	active_gamemode = new desired_gamemode
	log_debug("Setting gamemode to: [active_gamemode.name]... Source: [source].")

	if(source == "voting on_result")
		SSdiscord.send_message("Starting new round on [SSdmm_suite.map_name] with gamemode [active_gamemode.name]. ([length(all_clients)] players).")

	return TRUE

/subsystem/gamemode/Initialize()

	for(var/k in subtypesof(/gamemode/))
		var/gamemode/G = k
		if(initial(G.hidden))
			continue
		all_gamemodes += G

	log_subsystem(name,"Stored [length(all_gamemodes)] gamemodes.")

	return ..()

/subsystem/gamemode/PostInitialize()
	. = ..()
	set_active_gamemode(/gamemode/lobby,"Gamemode PostInitialize()")
	return .


/subsystem/gamemode/on_life()
	if(active_gamemode) active_gamemode.on_life()
	return TRUE