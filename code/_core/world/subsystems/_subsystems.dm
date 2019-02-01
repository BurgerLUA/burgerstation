/subsystem/
	var/name = "Base Subsystem"
	var/desc = "Subsystem for base functions. You shouldn't be seeing this."
	var/tick_rate = 1 //Tick delay for the subsystem, in deciseconds.
	var/priority = 0 //The lower the number, the more priority it recieves
	var/next_run = 0 //When the subsystem should run next

/subsystem/New()
	..()
	//What to do when this subsystem is spawned

/subsystem/proc/on_life()
	//When this subsystem runs. Returning ture means that this always runs, false means it runs once.
	return TRUE


