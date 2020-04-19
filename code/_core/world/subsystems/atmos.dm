#define REQUIRED_PRESSURE_DIFF 1


//Atmos should only update if and only if the surrounding NORTH|EAST|SOUTH|WEST has a GREATER gas composition (more gas, more air, ect) than the source tile.
//The above is checked if the density of the turf is changed in some way or the turf's gas was also changed.

//TODO: has_opaque_atom

SUBSYSTEM_DEF(air)
	name = "Atmospherics Subsystem"
	desc = "A very WIP atmos system."
	priority = SS_ORDER_AIR
	tick_rate = SECONDS_TO_TICKS(1)

	var/list/queued_atmos_updates = list()

/subsystem/air/Initialize()

	var/update_count = 0
	var/bad_count = 0

	for(var/turf/simulated/T in world)
		CHECK_TICK
		if(update_turf_air(T))
			queued_atmos_updates += T
			bad_count++
		update_count++

	log_subsystem(src.name, "Updated the air of [update_count] air turfs.")
	if(bad_count)
		log_subsystem(src.name, "WARNING: [bad_count] TURFS STILL NEEDED AN ATMOS UPDATE!.")

	return TRUE

/subsystem/air/proc/update_turf_air(var/turf/simulated/source_turf)

	. = FALSE

	for(var/dir in DIRECTIONS_CARDINAL)
		if(source_turf.blocks_air & dir)
			continue
		var/turf/T = get_step(source_turf,dir)
		if(!T || !is_simulated(T) || is_wall(T))
			continue
		var/turf/simulated/target_turf = T
		if(target_turf.blocks_air & turn(dir,180))
			continue

		for(var/gas_type in source_turf.air_contents)
			var/our_volume = source_turf.air_contents[gas_type] ? source_turf.air_contents[gas_type] : 0
			var/their_volume = target_turf.air_contents[gas_type] ? target_turf.air_contents[gas_type] : 0
			if(!their_volume || (our_volume - their_volume) >= REQUIRED_PRESSURE_DIFF)
				var/average = round( (our_volume + their_volume)/2 , 0.01 )
				source_turf.air_contents[gas_type] = average
				target_turf.air_contents[gas_type] = average
				target_turf.color = blend_colors(COLOR_BLACK,COLOR_CYAN,target_turf.air_contents["oxygen"])
				queued_atmos_updates |= target_turf
				. = TRUE

	if(.)
		source_turf.color = blend_colors(COLOR_BLACK,COLOR_BLUE,source_turf.air_contents["oxygen"]/40)
		queued_atmos_updates |= source_turf
	else
		source_turf.color = blend_colors(COLOR_BLACK,COLOR_RED,source_turf.air_contents["oxygen"]/40)
		queued_atmos_updates -= source_turf

	return .

/subsystem/air/on_life()

	for(var/k in queued_atmos_updates)
		CHECK_TICK
		update_turf_air(k)

	return TRUE

client/verb/air_test(var/pressure as num)
	set name = "Air Test"
	set category = "Debug"
	set hidden = FALSE

	if(mob)
		var/turf/simulated/S = get_turf(mob)
		if(S)
			S.air_contents["oxygen"] += pressure
			SSair.update_turf_air(S)

	return TRUE