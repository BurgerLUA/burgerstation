var/global/list/all_dialogue = list()

/subsystem/dialogue/
	name = "Dialogue Subsystem"
	desc = "Stores all the known dialogue in a list."
	priority = SS_ORDER_DIALOGUE

/subsystem/dialogue/on_life()

	for(var/A in subtypesof(/dialogue/))
		var/dialogue/D = new A
		all_dialogue[D.id] = D

	return FALSE