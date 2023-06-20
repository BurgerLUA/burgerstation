/obj/item/grenade/device/special/timed/
	icon = 'icons/obj/item/grenade_new.dmi'
	icon_state = "grenade"

/obj/item/grenade/device/special/timed/Generate()
	var/obj/item/device/timer/T = new(src)
	T.time_set = 30
	stored_trigger = T
	open = FALSE
	return ..()


/obj/item/grenade/device/special/timed/blackhole
	name = "blackhole grenade"
	desc_extended = "A special prebuilt grenade storing a volatile black hole that sucks up small objects to be sold to another dimension. The labeling indicates that the fuse is set to 3 seconds."
	paint_color = COLOR_PURPLE
	marker_color = COLOR_BLACK
	value = 400

/obj/item/grenade/device/special/timed/blackhole/get_base_value()
	return initial(value)

/obj/item/grenade/device/special/timed/blackhole/get_value()
	. = ..()
	for(var/obj/item/I in src.contents)
		. += I.get_value()

/obj/item/grenade/device/special/timed/blackhole/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	. = ..()

	var/turf/T = get_turf(src)

	if(!is_advanced(caller))
		visible_message(span("warning","\The [src.name] fails to deploy!"))
		return TRUE

	var/mob/living/advanced/A = caller

	anchored = TRUE

	icon = 'icons/obj/effects/portal.dmi'
	icon_state = "bhole3"

	play_sound('sound/effects/space_phase.ogg',T)

	suck(A,6)


/obj/item/grenade/device/special/timed/blackhole/proc/suck(var/mob/living/advanced/caller,var/sucks_left=0)


	var/turf/T = get_turf(src)

	var/limit = 20

	var/sucked = FALSE
	for(var/obj/item/I in view(5,src))
		if(limit <= 0)
			break
		if(I.anchored)
			continue
		if(!is_turf(I.loc))
			continue
		if(I.loc == T)
			I.force_move(src)
			sucked = TRUE
			continue
		I.force_move(get_step(I,get_dir(I,T)))
		limit--
		CHECK_TICK(50,FPS_SERVER)

	if(sucked)
		play_sound('sound/effects/portal_suck.ogg',T)

	if(sucks_left > 0)
		CALLBACK("\ref[src]_suck",8,src,src::suck(),caller,sucks_left-1)
	else
		if(is_player(caller))
			var/mob/living/advanced/player/P = caller
			var/value_of_contents = src.get_value() * 0.25
			value_of_contents = CEILING(value_of_contents,1)
			P.to_chat(span("notice","You've earned [value_of_contents] credits for that [src.name]."))
			P.adjust_currency(value_of_contents)
		qdel(src)


/obj/item/grenade/device/special/timed/decoy
	name = "decoy grenade"
	desc_extended = "A special prebuilt grenade storing a hardlight hologram dummy. The labeling indicates that the fuse is set to 3 seconds."
	paint_color = COLOR_GREEN
	marker_color = COLOR_GREEN_LIGHT
	value = 400

/obj/item/grenade/device/special/timed/decoy/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	. = ..()

	var/turf/T = get_turf(src)

	if(!is_advanced(caller))
		visible_message(span("warning","\The [src.name] fails to deploy!"))
		return TRUE

	var/mob/living/advanced/A = caller

	var/mob/living/simple/hologram/D = new(T)
	INITIALIZE(D)
	GENERATE(D)
	FINALIZE(D)
	D.appearance = A.appearance
	if(D.ai)
		D.ai.set_active(TRUE)



/obj/item/grenade/device/special/timed/barrier
	name = "barrier grenade"
	desc_extended = "A special prebuilt grenade storing a robust inflatable barrier. Note that the grenade cannot be used in certain areas. The labeling indicates that the fuse is set to 3 seconds."
	paint_color = COLOR_GREY_DARK
	marker_color = COLOR_RED
	value = 200

/obj/item/grenade/device/special/timed/barrier/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	. = ..()

	var/turf/T = get_turf(src)
	var/area/A = T.loc

	if(A.flags_area & FLAG_AREA_NO_CONSTRUCTION)
		visible_message(span("warning","\The [src.name] fails to deploy!"))
		return FALSE

	if(T.has_dense_atom)

		var/list/good_turfs = list()
		for(var/d in DIRECTIONS_ALL)
			var/turf/DT = get_step(T,d)
			if(!DT.can_move_to())
				continue
			if(DT.has_dense_atom)
				continue
			good_turfs += DT

		if(!good_turfs)
			visible_message(span("warning","\The [src.name] fails to deploy!"))
			return .

		for(var/k in T.contents)
			var/atom/movable/M = k
			if(!M.density)
				continue
			if(M.anchored)
				visible_message(span("warning","\The [src.name] fails to deploy!"))
				return .
			M.Move(pick(good_turfs))

		var/obj/structure/interactive/barrier/B = new(T)
		B.creator_ckey = caller.ckey ? caller.ckey : "#null"
		INITIALIZE(B)
		GENERATE(B)
		FINALIZE(B)
		play_sound('sound/effects/inflate.ogg',T)









/obj/item/grenade/device/special/timed/shell
	name = "shell grenade"
	desc_extended = "A special prebuilt grenade storing a special metalic foam that sprays on a donut shape around the grenade. Note that the grenade cannot be used in certain areas. The labeling indicates that the fuse is set to 3 seconds."
	paint_color = COLOR_GREY_LIGHT
	marker_color = COLOR_GOLD
	value = 300

/obj/item/grenade/device/special/timed/shell/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	. = ..()

	var/turf/T = get_turf(src)

	/*
	var/area/A = T.loc
	if(A.flags_area & FLAG_AREA_NO_CONSTRUCTION)
		visible_message(span("warning","\The [src.name] fails to deploy!"))
		return FALSE
	*/

	var/list/deploy_turfs = list()
	for(var/d in DIRECTIONS_ALL)
		var/turf/DT = get_step(T,d)
		if(!DT.can_move_to())
			continue
		if(DT.has_dense_atom)
			continue
		deploy_turfs[DT] = d

	var/success = FALSE
	var/has_a_bad_turf = TRUE
	for(var/k in deploy_turfs)
		var/turf/D = k
		var/direction = deploy_turfs[k]
		var/turf/forward = get_step(D,direction)
		var/bad_turf = FALSE
		if(D.has_dense_atom)
			for(var/j in D.contents)
				var/atom/movable/M = j
				if(!M.density)
					continue
				if(M.anchored)
					bad_turf = TRUE
					break
				if(M.Move(forward)) //out of the donut
					continue
				if(M.Move(T)) //into the donut
					continue
				bad_turf = TRUE
				break
		if(D.has_dense_atom)
			bad_turf = TRUE //Still dense
		if(bad_turf)
			has_a_bad_turf = TRUE
		else
			var/obj/structure/metal_foam/F = new(D)
			F.creator_ckey = caller.ckey ? caller.ckey : "#null"
			INITIALIZE(F)
			GENERATE(F)
			FINALIZE(F)
			success = TRUE

	if(has_a_bad_turf && !T.has_dense_atom)
		var/obj/structure/metal_foam/F = new(T)
		F.creator_ckey = caller.ckey ? caller.ckey : "#null"
		INITIALIZE(F)
		GENERATE(F)
		FINALIZE(F)
		success = TRUE



	if(success)
		play_sound('sound/effects/inflate.ogg',T)
	else
		visible_message(span("warning","\The [src.name] fails to deploy!"))
