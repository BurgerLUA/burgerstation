SUBSYSTEM_DEF(power)
	name = "Power Subsystem"
	desc = "Handle power processing and other cool things."
	priority = SS_ORDER_POWER

	tick_rate = SECONDS_TO_TICKS(1)

	tick_usage_max = 50

	var/list/power_network/all_power_networks = list()
	var/list/area/all_apc_areas = list()


/subsystem/power/unclog(var/mob/caller)
	tick_rate = -1
	. = ..()

/subsystem/power/Initialize()
	. = ..()
	for(var/k in SSarea.all_areas)
		var/area/A = SSarea.all_areas[k]
		if(!A || A.qdeleting)
			continue
		if(!A.requires_power)
			continue
		if(!A.linked_apc && A.link_to_parent_apc)
			var/area/PA = SSarea.all_areas[A.parent_type]
			while(TRUE)
				CHECK_TICK_HARD
				if(!PA)
					break
				if(PA.type == /area/) //End of the road.
					break
				if(!PA.requires_power) //Can't really find one.
					break
				if(PA.linked_apc) //Hey, we found one.
					PA.linked_apc.link_area(A)
					break
				PA = SSarea.all_areas[PA.parent_type] //Keep going until we find one.

		if(!A.linked_apc)
			if(!A.no_apc) log_error("WARNING: area of type [A.type] did not find an APC. Set area.no_apc to TRUE to remove this warning.")
			continue
		A.toggle_power_lights(A.default_state_power_lights,force=TRUE)
		A.toggle_power_machines(A.default_state_power_machines,force=TRUE)
		A.toggle_power_doors(A.default_state_power_doors,force=TRUE)
		CHECK_TICK_HARD

	log_subsystem(src.name,"Created [length(all_power_networks)] power networks at Initialize().")
	log_subsystem(src.name,"Created [length(all_apc_areas)] APC areas at Initialize().")

/subsystem/power/on_life()

	for(var/k in all_apc_areas)
		var/area/A = k
		if(!A || A.qdeleting)
			all_apc_areas -= k
			continue
		A.apc_process()
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	for(var/k in all_power_networks)
		var/power_network/PN = k
		if(!PN || PN.qdeleting)
			all_power_networks -= k
			continue
		PN.power_process()
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	return TRUE