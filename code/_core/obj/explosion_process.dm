/obj/explosion_process
	var/power = 0
	var/velocity_dir = 0x0

	collision_flags = FLAG_COLLISION_FLYING

/obj/explosion_process/debug/small
	power = 20

/obj/explosion_process/debug/medium
	power = 40

/obj/explosion_process/debug/large
	power = 80

/obj/explosion_process/Finalize()
	SSexplosion.active_explosions += src
	maptext = "[power]"
	return ..()

/obj/explosion_process/Destroy()
	SSexplosion.active_explosions -= src
	return ..()

/obj/explosion_process/proc/process()

	if(power <= 1)
		qdel(src)
		return FALSE

	var/list/valid_existing = list()
	var/list/valid_turfs = list()

	var/total_direction_mod = 0

	for(var/d in DIRECTIONS_CARDINAL)
		var/turf/T = get_step(src,d)
		if(!T) continue
		if(!T.Enter(src,src.loc))
			continue
		var/obj/explosion_process/existing = locate() in T.contents
		var/direction_mod = 1
		if(existing)
			direction_mod = max(0,power-existing.power)
			if(velocity_dir)
				if(d == velocity_dir)
					direction_mod *= 2
				else if(d == turn(velocity_dir,180))
					direction_mod *= 0.5
			if(existing.velocity_dir)
				if(d == existing.velocity_dir)
					direction_mod *= 2
				else if(d == turn(existing.velocity_dir,180))
					direction_mod *= 0.5
			valid_existing[T] = existing
		valid_turfs[T] = direction_mod
		total_direction_mod += direction_mod

	var/has_existing = length(valid_existing)

	for(var/k in valid_turfs)
		if(!total_direction_mod)
			break
		var/new_power_value = valid_turfs[k]
		var/turf/T = k
		var/obj/explosion_process/EP = has_existing ? valid_existing[k] : null
		var/power_to_give = (power * (new_power_value/total_direction_mod) * min(new_power_value,1))
		if(EP)
			EP.power = max(EP.power,power_to_give)
		else
			EP = new(T)
			EP.power = power_to_give
			EP.velocity_dir = get_dir(src,EP)
			INITIALIZE(EP)
			GENERATE(EP)
			FINALIZE(EP)

	power = (power*0.5) - 1

	if(power <= 1)
		qdel(src)
		return FALSE

	return TRUE