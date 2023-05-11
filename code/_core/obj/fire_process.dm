/obj/fire_process

	icon = 'icons/obj/effects/flamer_fire_effect.dmi'
	icon_state = "red_1"

	var/fire_power = 0
	var/initial_fire_power = 0

	var/momentum = 0x0

	var/loyalty_tag

	var/multiplier = 1

	var/atom/owner

	collision_flags = FLAG_COLLISION_CRAWLING

	damage_type = /damagetype/fire_turf

	density = TRUE

	hazardous = TRUE

/obj/fire_process/proc/do_damage(var/atom/movable/victim,var/distance_check=0)

	if(!victim || !victim.z || !src.z || victim.z != src.z)
		return FALSE

	if(CALLBACK_EXISTS("\ref[victim]_do_fire_ground_damage"))
		return FALSE

	if(distance_check <= 0)
		if(victim.loc != src.loc)
			return FALSE
	else
		if(get_dist(victim,src) > distance_check)
			return FALSE

	var/damagetype/DT = all_damage_types[damage_type]
	var/list/params = get_params()
	if(!victim.can_be_attacked(owner,src,params,DT))
		return FALSE
	var/atom/object_to_damage = victim.get_object_to_damage(owner,src,damage_type,params,TRUE,TRUE)
	. = DT.process_damage(owner,victim,src,object_to_damage,owner,1)
	CALLBACK("\ref[victim]_do_fire_ground_damage",10,src,src::do_damage(),victim) //Check again in 10 seconds.

/obj/fire_process/Crossed(atom/movable/O)
	. = ..()
	if(O.health) do_damage(O)

/obj/fire_process/Finalize()
	. = ..()
	SSexplosion.active_fires += src
	if(loc)
		for(var/k in loc.contents)
			var/atom/movable/M = k
			if(M == src)
				continue
			if(M.health) do_damage(k)

	set_light(3, 0.5, "#FF8C77",LIGHT_OMNI)


/obj/fire_process/Destroy()
	SSexplosion.active_fires -= src
	. = ..()

/obj/fire_process/proc/process()

	if(!loc || fire_power <= 0)
		qdel(src)
		return FALSE

	fire_power = min(fire_power,300) //Limit of 30 seconds.

	fire_power -= 0.1*0.5 //10% of a tile per explosion process tick.

	var/desired_alpha = min(100 + (fire_power/20)*(255-100),255)
	animate(src,alpha=desired_alpha,time=0.5)


	var/light_power = min(8,fire_power/20)

	set_light_sprite(light_power,light_power, "#FF8C77",LIGHT_OMNI)

	if(fire_power < 20) //Don't spread if we don't have enough fuel to spread.
		return FALSE

	if(!momentum)
		return TRUE

	var/list/possible_directions = DIRECTIONS_ALL
	var/list/directions_to_check = list()
	for(var/i=1,i<=4,i++)
		var/direction_choice = pick(possible_directions)
		directions_to_check += direction_choice
		possible_directions -= direction_choice

	var/turf/current_turf = loc

	for(var/d in directions_to_check)

		if(momentum && !((momentum | turn(momentum,45) | turn(momentum,-45)) & d))
			continue

		var/turf/T = get_step(current_turf,d)
		if(!T)
			continue

		if(T.density && !T.Enter(src,src.loc))
			if(T.health) do_damage(T,1)
			momentum &= ~d
			return TRUE

		if(T.has_dense_atom)
			var/should_return = FALSE
			for(var/k in T.contents)
				var/atom/movable/M = k
				if(M.density && !M.Cross(src,current_turf))
					momentum &= ~d
					should_return = TRUE
					if(M.health) do_damage(M,1)
			if(should_return)
				return TRUE

		var/obj/fire_process/FP = locate() in T.contents
		if(!FP || FP.loyalty_tag != src.loyalty_tag)
			FP = new(T)
			FP.initial_fire_power = src.initial_fire_power
			FP.fire_power = src.fire_power - 3
			FP.momentum = d
			FP.multiplier = src.multiplier
			FP.loyalty_tag = src.loyalty_tag
			FP.owner = src.owner
			INITIALIZE(FP)
			FINALIZE(FP)
		else
			FP.fire_power = max(FP.fire_power,src.fire_power - 3)
			FP.momentum = FP.momentum & momentum
			FP.multiplier = (FP.multiplier + src.multiplier) / 2

	momentum = 0x0

	return TRUE


/obj/fire_process/proc/get_params(var/atom/victim)
	. = list()
	.[PARAM_ICON_X] = rand(0,32)
	.[PARAM_ICON_Y] = rand(0,8)