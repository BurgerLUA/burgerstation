var/global/list/all_dialogue = list()

SUBSYSTEM_DEF(dialogue)
	name = "Dialogue Subsystem"
	desc = "Stores all the known dialogue in a list."
	priority = SS_ORDER_PRELOAD

/subsystem/dialogue/Initialize()
	for(var/A in subtypesof(/dialogue/))
		var/dialogue/D = new A
		all_dialogue[D.type] = D

	log_subsystem(name,"Initialized [length(all_dialogue)] dialogues.")

	return ..()