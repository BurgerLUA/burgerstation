/obj/structure/interactive/field_gen
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

/obj/structure/interactive/field_gen/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	INTERACT_CHECK
	INTERACT_DELAY(10)
	set_active(!active)
	return TRUE

/obj/structure/interactive/field_gen/on_destruction(var/damage = TRUE)
	. = ..()
	qdel(src)

/obj/structure/interactive/field_gen/active
	active = TRUE

/obj/structure/interactive/field_gen/Finalize()
	. = ..()
	set_active(active,force=TRUE)

/obj/structure/interactive/field_gen/proc/set_active(var/desired_active,var/force=FALSE,var/mob/caller) //caller is optional.

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

/obj/structure/interactive/field_gen/set_anchored(var/desired_anchored=TRUE,var/force=FALSE)
	. = ..()
	if(. && !desired_anchored)
		clear_linkages()
		if(active)
			set_active(FALSE)

/obj/structure/interactive/field_gen/post_move(var/atom/old_loc)
	. = ..()
	if(. && anchored) //Must be a shuttle or something special
		clear_linkages()



/obj/structure/interactive/field_gen/proc/clear_linkages() //This also clears gen walls, of course.

	for(var/d in src.linked_field_gens)
		clear_linkage(text2num(d))

	return TRUE


/obj/structure/interactive/field_gen/proc/clear_linkage(var/d)

	var/rd = turn(d,180)
	var/obj/structure/interactive/field_gen/FG = src.linked_field_gens["[d]"]

	//Delete our stuff.
	src.linked_field_gens -= "[d]"
	if(length(src.linked_field_gen_walls) && src.linked_field_gen_walls["[d]"])
		for(var/k in src.linked_field_gen_walls["[d]"])
			var/obj/field_generator_wall/W = k
			if(!W.qdeleting)
				qdel(W)

	//Clear their stuff.
	FG.linked_field_gens -= "[rd]"
	FG.linked_field_gen_walls["[rd]"].Cut()


/obj/structure/interactive/field_gen/proc/setup_barrier_chain(var/obj/structure/interactive/field_gen/FG,var/d) //FG is the target FG

	var/turf/T = get_turf(src)
	var/limit = get_dist(FG,src)
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
		T = get_step(T,d)
		if(T == FG.loc)
			continue
		var/obj/field_generator_wall/W = new(T)
		INITIALIZE(W)
		GENERATE(W)
		FINALIZE(W)
		src.linked_field_gen_walls["[d]"] += W
		FG.linked_field_gen_walls["[rd]"] += W



/obj/structure/interactive/field_gen/proc/setup_linkages()

	if(stored_field_energy <= 0)
		return FALSE

	for(var/d in DIRECTIONS_CARDINAL)
		if(src.linked_field_gens["[d]"]) //Already have a linkage.
			continue
		var/turf/T = get_turf(src)
		var/limit=VIEW_RANGE
		while(limit > 0)
			limit--
			T = get_step(T,d)
			var/obj/structure/interactive/field_gen/FG = locate() in T.contents
			if(FG && FG.active) //Don't need to give it energy. As long as src has energy, it can process.
				src.linked_field_gens["[d]"] = FG
				FG.linked_field_gens["[turn(d,180)]"] = FG
				setup_barrier_chain(FG,d) //No risk of running this twice.
				break

/obj/structure/interactive/field_gen/proc/process_field_gen()

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
		CALLBACK("\ref[src]_process_field_gen",SECONDS_TO_DECISECONDS(8),src,.proc/process_field_gen)

	if(old_field_state && stored_field_energy <= 0) //Stable field made unstable field.
		for(var/d in linked_field_gens)
			var/obj/structure/interactive/field_gen/FG = linked_field_gens[d]
			if(FG.stored_field_energy <= 0)
				clear_linkage(text2num(d))

	return TRUE

/obj/structure/interactive/field_gen/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)
	. = ..()
	if(istype(weapon,/obj/structure/interactive/emitter))
		emitter_hit()




/obj/structure/interactive/field_gen/proc/emitter_hit()

	var/old_emitter_state = clamp(stored_emitter_energy,0,6)
	stored_emitter_energy = min(stored_emitter_energy + 1,7) //Add 1, as it was hit.
	if(!old_emitter_state && stored_emitter_energy > 0 && !CALLBACK_EXISTS("\ref[src]_process_field_gen"))
		process_field_gen()
	else if(old_emitter_state != stored_emitter_energy)
		update_sprite()

/obj/structure/interactive/field_gen/update_overlays()
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