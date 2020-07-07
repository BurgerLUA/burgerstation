SUBSYSTEM_DEF(emote)
	name = "Emote Subsystem"
	desc = "Store all the emotes."
	priority = SS_ORDER_PRELOAD
	var/list/all_emotes = list()

/subsystem/emote/Initialize()

	for(var/k in subtypesof(/emote/))
		var/emote/E = k
		if(initial(E.id))
			E = new k
			all_emotes[E.id] = E

	log_subsystem(name,"Initialized [length(all_emotes)] emotes.")

	return ..()