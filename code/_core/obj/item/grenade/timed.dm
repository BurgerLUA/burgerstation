/obj/item/grenade/timed/
	icon = 'icons/obj/item/grenade_new.dmi'
	icon_state = "grenade"

	var/marker_color = "#FFFFFF"
	var/paint_color

/obj/item/grenade/timed/update_icon()

	icon = initial(icon)
	icon_state = initial(icon_state)

	if(spent)
		icon_state = "[icon_state]_spent"
	else if(stored_trigger?.active)
		icon_state = "[icon_state]_active"
	else if(open)
		icon_state = "[icon_state]_casing"

/obj/item/grenade/timed/update_overlays()

	. = ..()

	if(!open && paint_color)
		var/image/I = new/image(icon,null)
		if(spent)
			I.icon_state = "[initial(icon_state)]_spent_paint"
		else
			I.icon_state = "[initial(icon_state)]_paint"
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.color = paint_color
		add_overlay(I)

	if(!spent && !open)
		var/image/I = new/image(icon,"[initial(icon_state)]_marking")
		I.appearance_flags = src.appearance_flags | RESET_COLOR
		I.color = marker_color
		add_overlay(I)

/obj/item/grenade/timed/Generate()
	var/obj/item/device/timer/T = new(src)
	T.time_set = 30
	stored_trigger = T
	open = FALSE
	return ..()

/obj/item/grenade/timed/explosive
	name = "timed explosive grenade"
	desc = "Kaboom!"
	desc_extended = "A prebuilt timed explosive grenade. The labeling indicates that the fuse is set to 3 seconds."
	value = 50

	marker_color = COLOR_GREEN

/obj/item/grenade/timed/explosive/Generate()
	stored_containers += new /obj/item/container/simple/beaker/water(src)
	stored_containers += new /obj/item/container/simple/beaker/potassium(src)
	return ..()

/obj/item/grenade/timed/explosive_large
	name = "timed large explosive grenade"
	desc = "Kaboom!"
	desc_extended = "A prebuilt timed explosive grenade. The labeling indicates that the fuse is set to 3 seconds. This one has a larger payload."
	icon_state = "grenade_large"
	marker_color = COLOR_GREEN

/obj/item/grenade/timed/explosive_large/Generate()
	stored_containers += new /obj/item/container/simple/beaker/large/water(src)
	stored_containers += new /obj/item/container/simple/beaker/large/potassium(src)
	return ..()

/obj/item/grenade/timed/smoke/
	name = "timed smoke grenade"
	desc = "Kaboomish!"
	desc_extended = "A prebuilt timed smoke grenade. The labeling indicates that the fuse is set to 3 seconds."

	marker_color = COLOR_BLUE

/obj/item/grenade/timed/smoke/Generate()
	stored_containers += new /obj/item/container/simple/beaker/smoke_01(src)
	stored_containers += new /obj/item/container/simple/beaker/smoke_02(src)
	return ..()

/obj/item/grenade/timed/lube_smoke
	name = "timed lube smoke grenade"
	desc = "Kaboomish!"
	desc_extended = "A prebuilt timed lube smoke grenade. The labeling indicates that the fuse is set to 3 seconds."

	marker_color = COLOR_BLUE

/obj/item/grenade/timed/lube_smoke/Generate()
	stored_containers += new /obj/item/container/simple/beaker/large/lube_smoke_01(src)
	stored_containers += new /obj/item/container/simple/beaker/large/lube_smoke_02(src)
	return ..()

/obj/item/grenade/timed/cleaning_smoke
	name = "timed BLAM! cleaning smoke grenade"
	desc = "BLAM!"
	desc_extended = "A prebuilt timed cleaing smoke grenade. The labeling indicates that the fuse is set to 3 seconds."

	paint_color = COLOR_GREEN
	marker_color = COLOR_GREEN

/obj/item/grenade/timed/cleaning_smoke/Generate()
	stored_containers += new /obj/item/container/simple/beaker/large/cleaing_smoke_01(src)
	stored_containers += new /obj/item/container/simple/beaker/large/cleaing_smoke_02(src)
	return ..()



/obj/item/grenade/timed/emp
	name = "timed EMP grenade"
	desc = "Kaboomish!"
	desc_extended = "A prebuilt timed EMP grenade. The labeling indicates that the fuse is set to 3 seconds."
	icon_state = "grenade_large"
	marker_color = COLOR_CYAN

/obj/item/grenade/timed/emp/Generate()
	stored_containers += new /obj/item/container/simple/beaker/iron(src)
	stored_containers += new /obj/item/container/simple/beaker/uranium(src)
	return ..()


/obj/item/grenade/timed/incendiary
	name = "timed incendiary grenade"
	desc = "Kaboomish!"
	desc_extended = "A prebuilt timed incendiary grenade. The labeling indicates that the fuse is set to 3 seconds."

	paint_color = COLOR_RED
	marker_color = COLOR_ORANGE

/obj/item/grenade/timed/incendiary/Generate()
	stored_containers += new /obj/item/container/simple/beaker/oxygen(src)
	stored_containers += new /obj/item/container/simple/beaker/phoron(src)
	return ..()

/obj/item/grenade/timed/barrier
	name = "barrier grenade"
	desc_extended = "A special prebuilt grenade storing a robust inflatable barrier. Note that the grenade cannot be used in certain areas. The labeling indicates that the fuse is set to 3 seconds."
	paint_color = COLOR_GREY_DARK
	marker_color = COLOR_RED
	value = 200

/obj/item/grenade/timed/barrier/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_SCREWDRIVER)
			caller.to_chat(span("warning","\The [src.name] has nothing to unscrew!"))
			return TRUE

	. = ..()

/obj/item/grenade/timed/barrier/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

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









/obj/item/grenade/timed/shell
	name = "shell grenade"
	desc_extended = "A special prebuilt grenade storing a special metalic foam that sprays on a donut shape around the grenade. Note that the grenade cannot be used in certain areas. The labeling indicates that the fuse is set to 3 seconds."
	paint_color = COLOR_GREY_LIGHT
	marker_color = COLOR_GOLD
	value = 300

/obj/item/grenade/timed/shell/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_SCREWDRIVER)
			caller.to_chat(span("warning","\The [src.name] has nothing to unscrew!"))
			return TRUE

	. = ..()

/obj/item/grenade/timed/shell/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

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




/obj/item/grenade/timed/decoy
	name = "decoy grenade"
	desc_extended = "A special prebuilt grenade storing a hardlight hologram dummy. The labeling indicates that the fuse is set to 3 seconds."
	paint_color = COLOR_GREEN
	marker_color = COLOR_GREEN_LIGHT
	value = 400

/obj/item/grenade/timed/decoy/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_SCREWDRIVER)
			caller.to_chat(span("warning","\The [src.name] has nothing to unscrew!"))
			return TRUE

	. = ..()

/obj/item/grenade/timed/decoy/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

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






/obj/item/grenade/timed/blackhole
	name = "blackhole grenade"
	desc_extended = "A special prebuilt grenade storing a volatile black hole that sucks up small objects to be sold to another dimension. The labeling indicates that the fuse is set to 3 seconds."
	paint_color = COLOR_PURPLE
	marker_color = COLOR_BLACK
	value = 400

/obj/item/grenade/timed/blackhole/get_base_value()
	return initial(value)

/obj/item/grenade/timed/blackhole/get_value()
	. = ..()
	for(var/obj/item/I in src.contents)
		. += I.get_value()

/obj/item/grenade/timed/blackhole/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_SCREWDRIVER)
			caller.to_chat(span("warning","\The [src.name] has nothing to unscrew!"))
			return TRUE

	. = ..()

/obj/item/grenade/timed/blackhole/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

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

	suck(A,5)


/obj/item/grenade/timed/blackhole/proc/suck(var/mob/living/advanced/caller,var/sucks_left=0)


	var/turf/T = get_turf(src)

	var/limit = 10

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
		CHECK_TICK_SAFE(50,FPS_SERVER)

	if(sucked)
		play_sound('sound/effects/portal_suck.ogg',T)

	if(sucks_left > 0)
		CALLBACK("\ref[src]_suck",8,src,.proc/suck,caller,sucks_left-1)
	else
		if(is_player(caller))
			var/mob/living/advanced/player/P = caller
			var/value_of_contents = src.get_value() * 0.25
			value_of_contents = CEILING(value_of_contents,1)
			P.to_chat(span("notice","You've earned [value_of_contents] credits for that [src.name]."))
			P.adjust_currency(value_of_contents)
		qdel(src)