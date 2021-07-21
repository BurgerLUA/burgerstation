/obj/explosion_process
	var/original_power = 0
	var/power = 0
	var/velocity_dir = 0x0
	var/atom/owner
	var/atom/source
	var/turf/epicenter
	var/loyalty_tag
	var/multiplier = 1

	icon = 'icons/obj/effects/fire.dmi'
	icon_state = "3"

	collision_flags = FLAG_COLLISION_FLYING

	var/list/turf/blacklist = list()

/obj/explosion_process/Finalize()
	SSexplosion.active_explosions += src
	SSexplosion.add_data(loc,owner,source,epicenter,(power*0.9 + original_power*0.1)*multiplier,loyalty_tag)
	icon_state = "[clamp(FLOOR(power/30,1),1,3)]"
	if(velocity_dir)
		dir = velocity_dir
	return ..()

/obj/explosion_process/Destroy()
	owner = null
	source = null
	epicenter = null
	SSexplosion.active_explosions -= src
	. = ..()

/obj/explosion_process/proc/process()

	if(power <= 1)
		qdel(src)
		return FALSE

	var/list/valid_existing = list()
	var/list/valid_turfs = list()

	var/total_direction_mod = 0

	for(var/d in DIRECTIONS_CARDINAL)
		CHECK_TICK(50,FPS_SERVER)
		var/turf/T = get_step(src,d)
		if(!T) continue
		if(blacklist[T]) continue
		if(!T.Enter(src,src.loc))
			SSexplosion.add_data(T,owner,source,epicenter,(power*0.9 + original_power*0.1)*multiplier,loyalty_tag)
			continue
		var/obj/explosion_process/existing = locate() in T.contents
		var/direction_mod = 1
		if(existing)
			direction_mod = max(0,power-existing.power)
			if(velocity_dir)
				if(d == velocity_dir)
					direction_mod *= 2
				else if(d == turn(velocity_dir,180))
					direction_mod *= 0.1
				else
					direction_mod *= 0.5
			if(existing.velocity_dir)
				if(d == existing.velocity_dir)
					direction_mod *= 2
				else if(d == turn(existing.velocity_dir,180))
					direction_mod *= 0.1
				else
					direction_mod *= 0.5
			valid_existing[T] = existing
		else if(velocity_dir && velocity_dir == d)
			direction_mod *= 4
		else if(velocity_dir && turn(velocity_dir,180) == d)
			direction_mod *= 0.1

		valid_turfs[T] = direction_mod
		total_direction_mod += direction_mod
		blacklist[T] = TRUE

	var/has_existing = length(valid_existing)

	for(var/k in valid_turfs)
		CHECK_TICK(50,FPS_SERVER)
		if(!total_direction_mod)
			break
		var/new_power_value = valid_turfs[k]
		var/turf/T = k
		var/obj/explosion_process/EP = has_existing ? valid_existing[k] : null
		var/power_to_give = (power * (new_power_value/total_direction_mod) * min(new_power_value,1))*0.5
		if(EP)
			if(EP.power <= power_to_give)
				EP.power += power_to_give
				EP.original_power = max(EP.original_power,original_power)
				EP.blacklist += blacklist
				power -= power_to_give
		else
			EP = new(T)
			EP.original_power = original_power
			EP.power = power_to_give
			power -= power_to_give
			EP.velocity_dir = get_dir(src,EP)
			EP.owner = owner
			EP.source = source
			EP.epicenter = epicenter
			EP.loyalty_tag = loyalty_tag
			EP.multiplier = multiplier
			EP.blacklist = blacklist
			INITIALIZE(EP)
			GENERATE(EP)
			FINALIZE(EP)

	power = FLOOR((power*0.9) - 0.5,0.1)
	power = clamp(power,0,1000)

	if(power <= 1)
		qdel(src)
		return FALSE
	else
		icon_state = "[clamp(FLOOR(power/30,1),1,3)]"

	return TRUE