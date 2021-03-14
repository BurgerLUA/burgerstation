/obj/explosion_process
	var/power = 0
	var/velocity_dir = 0x0
	var/atom/owner
	var/atom/source
	var/turf/epicenter
	var/loyalty_tag


	icon = 'icons/obj/effects/fire.dmi'
	icon_state = "3"

	collision_flags = FLAG_COLLISION_FLYING

/obj/explosion_process/Finalize()
	SSexplosion.active_explosions += src
	SSexplosion.add_data(loc,owner,source,epicenter,power,loyalty_tag)
	icon_state = "[clamp(FLOOR(power/30,1),1,3)]"
	if(velocity_dir)
		dir = velocity_dir
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
		CHECK_TICK(50,FPS_SERVER)
		var/turf/T = get_step(src,d)
		if(!T) continue
		if(!T.Enter(src,src.loc))
			SSexplosion.add_data(T,owner,source,epicenter,power,loyalty_tag)
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
		CHECK_TICK(50,FPS_SERVER)
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
			EP.owner = owner
			EP.source = source
			EP.epicenter = epicenter
			EP.loyalty_tag = loyalty_tag
			INITIALIZE(EP)
			GENERATE(EP)
			FINALIZE(EP)

	power = (power*0.8) - 1

	if(power <= 1)
		qdel(src)
		return FALSE
	else
		icon_state = "[clamp(FLOOR(power/30,1),1,3)]"

	return TRUE