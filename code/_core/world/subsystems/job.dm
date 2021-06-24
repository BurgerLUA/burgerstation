SUBSYSTEM_DEF(job)
	name = "Job Subsystem"
	desc = "Stores all the known jobs in a list."
	priority = SS_ORDER_PRELOAD

	var/list/all_jobs = list()

/subsystem/job/Initialize()

	for(var/A in subtypesof(/job/))
		var/job/J = new A
		all_jobs[J.type] = J

	log_subsystem(name,"Initialized [length(all_jobs)] jobs.")

	. = ..()