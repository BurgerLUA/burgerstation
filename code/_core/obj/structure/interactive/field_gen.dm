/obj/structure/interactive/field_generator
	name = "field generator"
	icon = 'icons/obj/structure/field_gen.dmi'
	icon_state = "field_gen"

	density = TRUE
	anchored = TRUE

	collision_flags = FLAG_COLLISION_WALL
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	wire_powered = TRUE

	var/stored_emitter_energy = 0 //Green. Icon is 0 to 6, +1 for reserve.
	var/stored_field_energy = 0 //Blue. Icon is 0 to 3. +1 for reserve. 0 means unstable.

	var/active = FALSE

	health = /health/construction/field_generator/
	health_base = 500

	var/list/linked_field_gens = list()
	var/list/linked_field_gen_walls = list() //dimensional list

/obj/structure/interactive/field_generator/PreDestroy()
	set_active(FALSE,force=TRUE)
	. = ..()

/obj/structure/interactive/field_generator/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	INTERACT_CHECK
	INTERACT_DELAY(10)
	set_active(!active)
	return TRUE

/obj/structure/interactive/field_generator/on_destruction(var/damage = TRUE)
	. = ..()
	qdel(src)

/obj/structure/interactive/field_generator/active
	active = TRUE

/obj/structure/interactive/field_generator/Finalize()
	. = ..()
	set_active(active,force=TRUE)

/obj/structure/interactive/field_generator/proc/set_active(var/desired_active,var/force=FALSE,var/mob/caller) //caller is optional.

	if(!force && desired_active == active)
		return FALSE

	if(desired_active && !anchored)
		if(caller) caller.to_chat(span("warning","\The [src.name] must be secured firmly to the ground before it can turn on."))
		return FALSE

	active = desired_active

	if(caller)
		caller.visible_message(
			span("notice","\The [caller.name] turns [active ? "on" : "off"] \the [src.name]."),
			span("notice","You turn [active ? "on" : "off"] \the [src.name].")
		)
	else
		src.visible_message(
			span("notice","\The [src.name] turns [active ? "on" : "off"].")
		)

	if(active) //Turning it on. Check the links.
		setup_linkages()
	else //Turning it off. Clears the links.
		clear_linkages()

	update_sprite()

	return TRUE

/obj/structure/interactive/field_generator/set_anchored(var/desired_anchored=TRUE,var/force=FALSE)
	. = ..()
	if(. && !desired_anchored)
		clear_linkages()
		if(active)
			set_active(FALSE)

/obj/structure/interactive/field_generator/post_move(var/atom/old_loc)
	. = ..()
	if(. && anchored) //Must be a shuttle or something special
		clear_linkages()

/obj/structure/interactive/field_generator/proc/clear_linkages() //This also clears gen walls, of course.

	for(var/d in src.linked_field_gens)
		clear_linkage(text2num(d))

	return TRUE


/obj/structure/interactive/field_generator/proc/clear_linkage(var/d) //d is a num.

	var/rd = turn(d,180)
	var/obj/structure/interactive/field_generator/FG = src.linked_field_gens["[d]"]

	//Clear their stuff.
	FG.linked_field_gens -= "[rd]"
	if(FG.linked_field_gen_walls["[rd]"])
		FG.linked_field_gen_walls["[rd]"].Cut()

	//Delete our stuff.
	src.linked_field_gens -= "[d]"
	if(src.linked_field_gen_walls["[d]"])
		for(var/k in src.linked_field_gen_walls["[d]"])
			var/obj/field_generator_wall/W = k
			if(!W || !W.qdeleting)
				qdel(W)
			CHECK_TICK(50,FPS_SERVER)
		src.linked_field_gen_walls["[d]"].Cut()


/obj/structure/interactive/field_generator/proc/update_barrier_chains()

	. = FALSE

	for(var/d in src.linked_field_gens) //d is a string
		var/obj/structure/interactive/field_generator/FG = src.linked_field_gens[d]
		var/is_stable_connection = FG.active && src.active && (FG.stored_field_energy > 0 || src.stored_field_energy > 0)
		if(is_stable_connection)
			. = TRUE
		for(var/k in src.linked_field_gen_walls[d])
			var/obj/field_generator_wall/W = k
			if(is_stable_connection)
				W.alpha = initial(W.alpha)
				W.set_density(1)
			else
				W.alpha = 0
				W.set_density(0)

/obj/structure/interactive/field_generator/proc/setup_barrier_chain(var/obj/structure/interactive/field_generator/FG,var/d) //FG is the target FG

	var/turf/T = get_turf(src)
	var/limit = get_dist(FG,src) + 2
	var/rd = turn(d,180)

	if(src.linked_field_gen_walls["[d]"])
		src.linked_field_gen_walls["[d]"].Cut()
	else
		src.linked_field_gen_walls["[d]"] = list()

	if(FG.linked_field_gen_walls["[rd]"])
		FG.linked_field_gen_walls["[rd]"].Cut()
	else
		FG.linked_field_gen_walls["[rd]"] = list()

	while(limit > 0) //Safety in case shit goes wrong.
		limit--
		var/obj/field_generator_wall/W = new(T)
		W.dir = d
		W.icon_state = "beam"
		INITIALIZE(W)
		GENERATE(W)
		FINALIZE(W)
		src.linked_field_gen_walls["[d]"] += W
		FG.linked_field_gen_walls["[rd]"] += W
		if(T == FG.loc)
			W.icon = 'icons/obj/effects/field_generator_beam_large.dmi'
			W.pixel_x = -16
			W.pixel_y = -16
			W.dir = rd
			break
		if(T == src.loc)
			W.icon = 'icons/obj/effects/field_generator_beam_large.dmi'
			W.pixel_x = -16
			W.pixel_y = -16
		else
			W.icon = 'icons/obj/effects/field_generator_beam.dmi'
		T = get_step(T,d)




/obj/structure/interactive/field_generator/proc/setup_linkages()
	. = FALSE
	for(var/d in DIRECTIONS_CARDINAL)
		if(src.linked_field_gens["[d]"]) //Already have a linkage.
			continue
		var/turf/T = get_turf(src)
		var/limit=VIEW_RANGE
		while(limit > 0)
			limit--
			T = get_step(T,d)
			if(!T) break //Off the map.
			var/obj/structure/interactive/field_generator/FG = locate() in T.contents
			if(FG && FG.active) //Don't need to give it energy. As long as src has energy, it can process.
				src.linked_field_gens["[d]"] = FG
				FG.linked_field_gens["[turn(d,180)]"] = FG
				setup_barrier_chain(FG,d) //No risk of running this twice.
				. = TRUE
				break
	if(.)
		update_barrier_chains()

/obj/structure/interactive/field_generator/proc/process_field_gen()

	//For icon updating.
	var/old_emitter_state = clamp(stored_emitter_energy,0,6)
	var/old_field_state = clamp(stored_field_energy,0,3)

	if(stored_emitter_energy > 0)
		stored_field_energy = min(4,stored_field_energy + 1) //Going stable.
		stored_emitter_energy--
	else
		stored_field_energy = max(0,stored_field_energy - 1) //Going unstable.

	if(old_emitter_state != stored_emitter_energy || old_field_state != stored_field_energy)
		update_sprite()

	if(stored_emitter_energy > 0 || stored_field_energy > 0)
		CALLBACK("\ref[src]_process_field_gen",SECONDS_TO_DECISECONDS(8),src,src::process_field_gen())

	if( (old_field_state > 0 && stored_field_energy <= 0) || (old_field_state <= 0 && stored_field_energy > 0) ) //Stable field made unstable field, or vice vesa.
		update_barrier_chains()

	return TRUE

/obj/structure/interactive/field_generator/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)
	. = ..()
	if(istype(weapon,/obj/structure/interactive/emitter))
		emitter_hit()




/obj/structure/interactive/field_generator/proc/emitter_hit()

	var/old_emitter_state = clamp(stored_emitter_energy,0,6)
	stored_emitter_energy = min(stored_emitter_energy + 1,7) //Add 1, as it was hit.
	if(!old_emitter_state && stored_emitter_energy > 0 && !CALLBACK_EXISTS("\ref[src]_process_field_gen"))
		process_field_gen()
	else if(old_emitter_state != stored_emitter_energy)
		update_sprite()

/obj/structure/interactive/field_generator/update_overlays()
	. = ..()
	if(active)
		var/image/I = new/image(icon,"on")
		add_overlay(I)
	if(stored_emitter_energy > 0) //Green.
		var/image/I = new/image(icon,"p[clamp(stored_emitter_energy,1,6)]")
		add_overlay(I)
	if(stored_field_energy > 0) //Blue
		var/image/I = new/image(icon,"a[clamp(stored_emitter_energy,1,3)]")
		add_overlay(I)