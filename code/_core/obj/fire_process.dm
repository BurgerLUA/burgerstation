/obj/fire_process

	icon = 'icons/obj/effects/flamer_fire_effect.dmi'
	icon_state = "red_1"

	var/fire_power = 0
	var/initial_fire_power = 0

	var/momentum = 0x0

	var/loyalty_tag

	var/multiplier = 1

	var/atom/source

	collision_flags = FLAG_COLLISION_CRAWLING

/obj/fire_process/New(var/desired_loc)
	. = ..()
	SSexplosion.active_fires += src

/obj/fire_process/Destroy()
	SSexplosion.active_fires -= src
	. = ..()

/obj/fire_process/proc/process()

	var/turf/current_turf = get_turf(src)

	if(fire_power <= 0)
		qdel(src)
		return FALSE

	fire_power -= DECISECONDS_TO_SECONDS(1)

	if(fire_power <= initial_fire_power*0.5)
		return FALSE

	if(!momentum)
		return TRUE

	for(var/d in DIRECTIONS_CARDINAL)

		if(momentum && !((momentum | turn(momentum,45) | turn(momentum,-45)) & d))
			continue

		var/turf/T = get_step(current_turf,d)
		if(!T)
			continue

		if(!T.Enter(src,src.loc))
			momentum &= ~d
			return TRUE

		for(var/k in T.contents)
			var/atom/movable/M = k
			if(is_living(M))
				var/mob/living/L = M
				if(allow_hostile_action(src.loyalty_tag,L))
					L.ignite(fire_power*multiplier,source=source)
			if(M.density && !M.Cross(src,current_turf))
				momentum &= ~d
				return TRUE

		var/obj/fire_process/FP = locate() in T.contents
		if(!FP || FP.loyalty_tag != src.loyalty_tag)
			FP = new(T)
			FP.initial_fire_power = src.initial_fire_power
			FP.fire_power = src.fire_power - 1
			FP.momentum = d
			FP.multiplier = src.multiplier
			FP.loyalty_tag = src.loyalty_tag
			FP.source = src.source
		else
			FP.fire_power = max(FP.fire_power,src.fire_power - 1)
			FP.momentum = FP.momentum & momentum
			FP.multiplier = (FP.multiplier + src.multiplier) / 2

	momentum = 0x0

	return TRUE