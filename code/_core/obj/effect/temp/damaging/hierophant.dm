/obj/effect/temp/hazard/hierophant
	name = "hierophant blast"
	icon = 'icons/obj/effects/hierophant.dmi'
	icon_state = "blast"
	duration = 7
	hazard_delay = 6
	hazard_range = 0
	damage_type = /damagetype/ranged/magic/hierophant
	plane = PLANE_BLOOD
	layer = 0
	var/blasts_left = 10
	var/copy_delay = 3
	var/should_teleport = FALSE

/obj/effect/temp/hazard/hierophant/New(var/desired_location,var/desired_time,var/desired_owner)
	. = ..()
	play_sound('sound/effects/wand_teleport.ogg',get_turf(src))

/obj/effect/temp/hazard/hierophant/Initialize()
	CALLBACK("copy_hazard_\ref[src]",copy_delay,src,.proc/copy_hazard)
	return ..()

/obj/effect/temp/hazard/hierophant/get_params(var/atom/victim)

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.horizontal)
			return ..()

	. = list()
	.[PARAM_ICON_X] = rand(0,32)
	.[PARAM_ICON_Y] = rand(0,14)


/obj/effect/temp/hazard/hierophant/proc/copy_hazard()

	if(blasts_left > 0)
		blasts_left--
		var/turf/T = get_step(src,dir)
		var/turf/current_turf = get_turf(src)
		if(!current_turf || !current_turf)
			return FALSE
		if(!current_turf.is_safe_teleport(FALSE) && !T.is_safe_teleport(FALSE))
			return FALSE
		var/obj/effect/temp/hazard/hierophant/H = new(T,desired_owner = owner)
		H.blasts_left = blasts_left
		H.copy_delay = copy_delay
		H.should_teleport = should_teleport
		if(H.blasts_left == initial(blasts_left)/2)
			H.dir = turn(dir,pick(90,180,270))
		else
			H.dir = dir
		INITIALIZE(H)
	else if(should_teleport && ismovable(owner))
		var/atom/movable/M = owner
		var/turf/T = get_turf(src)
		if(T && T.is_safe_teleport())
			var/turf/old_turf = get_turf(M)
			new /obj/effect/temp/phase/out(old_turf)
			M.force_move(T)
			new /obj/effect/temp/phase(T)

	return TRUE

/obj/effect/temp/hazard/hierophant/single/copy_hazard()
	return TRUE

/obj/effect/temp/hazard/hierophant/targeted
	var/atom/target

/obj/effect/temp/hazard/hierophant/targeted/copy_hazard()

	if(target == loc)
		blasts_left = 0

	if(blasts_left > 0)
		blasts_left--
		var/turf/T = get_step(src,dir)
		var/turf/current_turf = get_turf(src)
		if(!current_turf.is_safe_teleport(FALSE) && !T.is_safe_teleport(FALSE))
			return FALSE
		var/obj/effect/temp/hazard/hierophant/targeted/H = new(T,desired_owner = owner)
		H.blasts_left = blasts_left
		H.copy_delay = copy_delay
		H.target = target
		H.dir = get_true_4dir(get_dir(T,H.target))
		H.should_teleport = should_teleport
		INITIALIZE(H)
	else if(should_teleport && ismovable(owner))
		var/atom/movable/M = owner
		var/turf/T = get_turf(src)
		if(T && T.is_safe_teleport())
			var/turf/old_turf = get_turf(M)
			new /obj/effect/temp/phase/out(old_turf)
			M.force_move(T)
			new /obj/effect/temp/phase(T)

	return TRUE