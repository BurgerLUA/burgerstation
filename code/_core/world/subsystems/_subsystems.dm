/subsystem/
	var/name = "Base Subsystem"
	var/desc = "Subsystem for base functions. You shouldn't be seeing this."

	var/tick_rate = 0 //Tick delay for the subsystem, in frames. Set to 0 if you don't want it to run.
	var/priority = 0 //High number = runs later
	var/next_run = 0 //When the subsystem should run next

//What to do when this subsystem is spawned
/subsystem/proc/PreInit()

//When this subsystem runs for the first time.
/subsystem/proc/Initialize()

//When this subsystem runs. Returning true means that this always runs, false means it doesn't run.
/subsystem/proc/on_life()
	return FALSE

//When the old subsystem hangs and we gotta replace it with a new one.
/subsystem/proc/Recover()
