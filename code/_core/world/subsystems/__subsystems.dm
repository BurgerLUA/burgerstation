#define DEFAULT_CPU_USAGE 75
#define DEFAULT_TICK_USAGE 75

/subsystem/
	var/name = "Base Subsystem"
	var/desc = "Subsystem for base functions. You shouldn't be seeing this."

	var/tick_rate = 0 //Tick delay for the subsystem, in frames. Set to 0 if you don't want it to run.
	var/priority = 0 //High number = runs later
	var/next_run = 0 //When the subsystem should run next
	var/life_time = 0 //Time it takes for it to complete a life cycle.

	var/cpu_usage_max = DEFAULT_CPU_USAGE
	var/tick_usage_max = DEFAULT_TICK_USAGE

	var/debug = FALSE

	var/overtime_count = 0
	var/overtime_max = 10

	var/last_run_duration = 0
	var/total_run_duration = 0

	var/use_time_dialation = TRUE


/subsystem/proc/unclog(var/mob/caller)
	broadcast_to_clients("SHITTERS CLOGGED: Subsystem [name] has been restarted by [caller.ckey].")
	return TRUE

/subsystem/New(var/desired_loc)
	tick_rate = FLOOR(tick_rate,1)
	return ..()


//What to do when this subsystem is spawned. It's like New() but not really.
/subsystem/proc/PreInitialize()

//When this subsystem runs for the first time.
//subsystem/Initialize()
//	return ..()

//When this subsystem runs.
/subsystem/proc/on_life()
	return FALSE

//When the old subsystem hangs and we gotta replace it with a new one.
/subsystem/proc/Recover()
	return TRUE

/subsystem/proc/on_shutdown()
	return TRUE