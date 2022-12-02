/obj/fire_process

	icon = 'icons/obj/effects/flamer_fire_effect.dmi'
	icon_state = "red_1"

	var/fire_power = 0
	var/initial_fire_power = 0

	var/momentum = 0x0

	var/loyalty_tag

	var/multiplier = 1

/obj/fire_process/New(var/desired_loc)
	. = ..()
	SSexplosion.active_fires += src

/obj/fire_process/Destroy()
	SSexplosion.active_fires -= src
	. = ..()

/obj/fire_process/proc/process()

	var/turf/current_turf = get_turf(src)

	if(current_turf.has_dense_atom)

		if(!current_turf.Enter(src,src.loc))
			momentum = 0x0
			fire_power--

		for(var/k in current_turf.contents)
			var/atom/movable/M = k
			if(fire_power <= 0)
				return TRUE
			var/remove_fire = FALSE
			if(is_living(M))
				var/mob/living/L = M
				if(allow_hostile_action(src.loyalty_tag,L))
					L.adjust_fire_stacks(fire_power*multiplier)
					remove_fire = TRUE
			if(M.density && !M.Cross(src,src.loc))
				momentum = 0x0
				remove_fire = TRUE
			if(remove_fire)
				fire_power--

	if(fire_power <= 0)
		qdel(src)
		return FALSE

	if(initial_fire_power * 0.5 >= fire_power)
		fire_power -= 1
		return TRUE

	if(!momentum)
		return TRUE

	for(var/d in DIRECTIONS_CARDINAL)
		var/local_momentum = momentum == -1 ? d : momentum
		if(local_momentum && (d & turn(local_momentum,180)))
			continue
		var/turf/T = get_step(current_turf,d)
		if(!T)
			continue
		var/obj/fire_process/FP = locate() in T.contents
		if(!FP || FP.loyalty_tag != src.loyalty_tag)
			FP = new(T)
			FP.initial_fire_power = src.initial_fire_power
			FP.fire_power = src.fire_power * 0.25
			FP.momentum = local_momentum
			FP.multiplier = src.multiplier
			FP.loyalty_tag = src.loyalty_tag
		else
			FP.fire_power += fire_power * 0.125
			FP.momentum = FP.momentum & local_momentum
			FP.multiplier = (FP.multiplier + src.multiplier) / 2
		fire_power -= 1

	return TRUE