SUBSYSTEM_DEF(cqc)
	name = "CQC Subsystem"
	desc = "Stores all the known cqc moves."
	priority = SS_ORDER_FIRST

	var/list/all_cqc = list()

	var/list/cqc_category = list()

/subsystem/cqc/Initialize()

	for(var/k in subtypesof(/cqc/))
		var/cqc/C = k
		if(!initial(C.damage_type))
			continue
		C = new k
		all_cqc[C.type] = C
		if(C.category)
			if(!cqc_category[C.category])
				cqc_category[C.category] = list()
			cqc_category[C.category] += C


	sort_tim(all_cqc, /proc/cmp_cqc_priority, associative = TRUE)

	return ..()