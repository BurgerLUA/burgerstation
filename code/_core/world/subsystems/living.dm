var/global/list/all_living = list()

SUBSYSTEM_DEF(living)
	name = "Living Subsystem"
	desc = "Controls the life of mobs."
	tick_rate = DECISECONDS_TO_TICKS(LIFE_TICK)
	priority = SS_ORDER_LIFE

	var/advanced_ticks = 0

	tick_usage_max = 80
	cpu_usage_max = 80

	use_time_dialation = FALSE

	var/list/stored_addictions = list()

/subsystem/living/Initialize()

	for(var/k in all_living)
		var/mob/living/L = k
		if(istype(L.loc,/turf/simulated/wall))
			qdel(L)
			continue
		INITIALIZE(L)
		GENERATE(L)
		FINALIZE(L)

	log_subsystem(name,"Initialized [length(all_living)] living beings.")

	for(var/k in subtypesof(/addiction/))
		var/addiction/A = new k
		stored_addictions[k] = A

	return ..()

/subsystem/living/proc/process_living(var/mob/living/L,var/do_slow=FALSE)
	L.on_life()
	if(do_slow)
		L.on_life_slow()
	return TRUE

/subsystem/living/on_life()

	var/do_slow = advanced_ticks >= LIFE_TICKS_PER_SLOW_LIFE_TICKS

	for(var/k in all_living)
		var/mob/living/L = k
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		if(process_living(L,do_slow) == null)
			if(!L.ckey_last)
				log_error("Warning! [L.get_debug_name()] is not running process_living() correctly! They will be deleted as a result.")
				qdel(L)
			else
				log_error("Warning! [L.get_debug_name()] is not running process_living() correctly! They currently have a ckey associated, so they will be notified instead of deleted.")
				L.to_chat(span("danger","It appears your character experienced a script error. If this message persists, please cryo and rejoin while notifying a developer."))

	if(do_slow)
		advanced_ticks = 0
	else
		advanced_ticks += 1

	return TRUE