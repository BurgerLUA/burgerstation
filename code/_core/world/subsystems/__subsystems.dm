#define DEFAULT_TICK_USAGE 75

/subsystem/
	var/name = "Base Subsystem"
	var/desc = "Subsystem for base functions. You shouldn't be seeing this."

	var/tick_rate = -1 //Tick delay for the subsystem, in frames. Set to -1 if you don't want it to run. Setting to 0 enables custom behavior.
	var/priority = 0 //High number = runs later
	var/next_run = 0 //When the subsystem should run next
	var/life_time = 0 //Time it takes for it to complete a life cycle.

	var/tick_usage_max = DEFAULT_TICK_USAGE

	var/debug = FALSE

	var/overtime_count = 0
	var/overtime_max = 10

	var/use_time_dialation = TRUE

	var/initialized = FALSE
	var/generated = FALSE
	var/finalized = FALSE

	var/run_failures = 0

	var/bypass_single_life_limit = FALSE

/subsystem/proc/Initialize()
	if(initialized)
		CRASH("WARNING: [src.get_debug_name()] was initialized twice!")
		return TRUE
	return TRUE

/subsystem/proc/PostInitialize()
	return TRUE

/subsystem/proc/Generate() //Generate the atom, giving it stuff if needed.
	if(generated)
		CRASH("WARNING: [src.get_debug_name()] was generated twice!")
		return TRUE
	return TRUE

/subsystem/proc/Finalize() //We're good to go.
	if(finalized)
		CRASH("WARNING: [src.get_debug_name()] was finalized twice!")
		return TRUE
	return TRUE



/subsystem/proc/unclog(var/mob/caller)
	if(caller.ckey)
		broadcast_to_clients("SHITTERS CLOGGED: Subsystem [name] has been restarted by [caller.ckey].")
	else
		broadcast_to_clients("SHITTERS CLOGGED: Subsystem [name] has been restarted automatically by the server's failsafe.")
	return TRUE

/subsystem/New(var/desired_loc)
	if(tick_rate > 0)
		tick_rate = FLOOR(tick_rate,1)
		if(!tick_rate)
			tick_rate = 1
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