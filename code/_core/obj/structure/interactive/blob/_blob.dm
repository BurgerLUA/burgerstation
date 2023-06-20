/obj/structure/interactive/blob/
	name = "blob piece"
	icon = 'icons/obj/structure/blob.dmi'
	var/has_damaged_state = FALSE

	var/obj/structure/interactive/blob/core/linked_core
	var/list/obj/structure/interactive/blob/adjacent_blobs

	color = "#80CC2A"

	plane = PLANE_MOVABLE

	anchored = TRUE

	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC
	collision_dir = NORTH | EAST | SOUTH | WEST

	damage_type = /damagetype/blob_attack/

	health = /health/blob
	health_base = 250

	density = TRUE

	var/health_states = 0

	var/turn_angle = 0

	var/last_state = 0

	var/super = FALSE //Only really applies to walls.

/obj/structure/interactive/blob/PreDestroy()

	if(linked_core)
		linked_core.linked_walls -= src
		linked_core.linked_nodes -= src
		linked_core = null

	for(var/k in adjacent_blobs)
		var/obj/structure/interactive/blob/B = k
		B.adjacent_blobs -= src
		adjacent_blobs -= B

	. = ..()

/obj/structure/interactive/blob/proc/grow_charge(var/obj/structure/interactive/blob/original_blob,var/obj/structure/interactive/blob/last_blob,var/tolerance=1,var/turf/priority_turf)

	if(src.qdeleting || !original_blob || original_blob.qdeleting || !linked_core || linked_core.qdeleting)
		return FALSE

	tolerance += 0.1

	var/prefered_dir = last_blob ? get_dir_advanced(last_blob,src) : null //Keep the momentum.
	var/prefered_dir_2 = original_blob ? get_dir_advanced(original_blob,src) : null //Move away from the core to expand.
	if(linked_core)
		health.adjust_loss_smart(brute = -linked_core.heal_amount)
	if(update_health_state())
		update_sprite()

	if(src.super) //Supers can't make anything.
		return TRUE

	var/list/possible_options = list()
	var/list/possible_options_super = list()
	for(var/k in adjacent_blobs)
		var/obj/structure/interactive/blob/B = k
		var/d = get_dir_advanced(src,B)
		if(B.color != color)
			continue
		if(priority_turf) //Prioritize blobs getting attacked.
			if(d & get_dir_advanced(src,priority_turf))
				possible_options += B
				if(B.super)
					possible_options_super += B
				continue
		else //Not getting attacked? Move away from the core to expand.
			if(prefered_dir_2 && d & prefered_dir_2)
				possible_options += B
				if(B.super)
					possible_options_super += B
				continue
			if(prefered_dir && d & prefered_dir) //Looks like we're kinda stuck. Float around in circles if possible.
				possible_options += B
				if(B.super)
					possible_options_super += B
				continue

	var/options = length(possible_options)
	if(options >= tolerance)
		var/obj/structure/interactive/blob/chosen_blob
		if(length(possible_options_super))
			chosen_blob = pick(possible_options_super)
		else
			chosen_blob = pick(possible_options)
		CALLBACK("blob_grow_\ref[src]",1,chosen_blob,src::grow_charge(),original_blob,src,tolerance,priority_turf)
	else
		var/list/possible_spawns = list()
		for(var/d in DIRECTIONS_CARDINAL)
			var/turf/T = get_step(src,d)
			if(linked_core && T == priority_turf)
				linked_core.lost_turfs -= priority_turf
			var/atom/victim = T.change_victim(src)
			if(!victim) //Something went wrong.
				continue
			if(istype(victim,/obj/structure/interactive/blob/) && victim.color == src.color) //No friendly fire!
				continue
			if(victim != T && victim.health) //Attack blocking objects (and mobs).
				spawn src.attack(src,victim,precise=TRUE)
				break
			else if(T.density && (T.density_north || T.density_south || T.density_east || T.density_west) && T.health) //Attack blocking walls.
				spawn src.attack(src,T,precise=TRUE)
				break
			else //Turf is clear. Add it to a possible spawn.
				possible_spawns += T

		if(length(possible_spawns)) //Supers can't make walls.

			var/make_super = length(linked_core.linked_walls) > linked_core.blob_limit

			var/turf/T = pick(possible_spawns)
			var/obj/structure/interactive/blob/node/found_node = locate() in range(4,T)

			var/obj/structure/interactive/blob/B
			if(found_node)
				B = new/obj/structure/interactive/blob/wall(T,linked_core) //Already a node nearby. Make one.
				if(make_super)
					B.super = TRUE
					B.name = "super [initial(B.name)]"
			else
				B = new/obj/structure/interactive/blob/node(T,linked_core) //Make a node if there is none.
			B.color = color
			INITIALIZE(B)
			FINALIZE(B)
			if(!make_super)
				B.health.adjust_loss_smart(brute = B.health.health_current - linked_core.heal_amount)
			B.update_sprite()

			var/list/direction_offsets = get_directional_offsets(T,src)
			var/matrix/M = B.get_base_transform()
			M.Scale(0.1)
			M.Translate(direction_offsets[1]*TILE_SIZE,direction_offsets[2]*TILE_SIZE)
			B.transform = M
			animate(B,transform=B.get_base_transform(),pixel_x=0,pixel_y=0,time=10)

	return TRUE

/obj/structure/interactive/blob/New(var/desired_loc,var/obj/structure/interactive/blob/core/desired_owner)
	adjacent_blobs = list()
	. = ..()
	turn_angle = pick(0,90,180,270)
	if(desired_owner)
		linked_core = desired_owner
		linked_core.linked_walls += src

/obj/structure/interactive/blob/Finalize()
	. = ..()

	for(var/d in DIRECTIONS_CARDINAL)
		var/turf/T = get_step(src,d)
		if(!T)
			continue
		var/obj/structure/interactive/blob/B = locate() in T.contents
		if(B)
			adjacent_blobs |= B
			B.adjacent_blobs |= src

	update_health_state()
	update_sprite()

/obj/structure/interactive/blob/update_icon()
	. = ..()
	icon_state = "[initial(icon_state)]_[last_state]"

/obj/structure/interactive/blob/can_be_attacked(var/atom/attacker,var/atom/weapon,var/params,var/damagetype/damage_type)
	return TRUE

/obj/structure/interactive/blob/can_attack(var/atom/attacker,var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(!health || health.health_current <= 0 || !color || color == "#FFFFFF")
		return FALSE

	if(is_living(victim))
		var/mob/living/L = victim
		if(L.dead)
			return FALSE
		if(L.loyalty_tag == "Blob")
			return FALSE

	return ..()

/obj/structure/interactive/blob/proc/update_health_state()
	. = 0
	var/current_state = health && health_states ? FLOOR( (health.health_current / health.health_max) * health_states,1) : 0
	if(last_state != current_state)
		if(last_state > current_state)
			. = -1 //Decreasing
		else
			. = 1 //Increasing
	last_state = current_state

/obj/structure/interactive/blob/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	if(!src.z)
		return ..()

	var/turf/T = src.loc
	if(linked_core)
		linked_core.lost_turfs += T //Don't worry about duplicate turfs.
	. = ..()
	var/state_code = update_health_state()
	if(state_code)
		if(state_code == -1) //Decreasing health.
			play_sound(pick('sound/effects/impacts/flesh_01.ogg','sound/effects/impacts/flesh_02.ogg','sound/effects/impacts/flesh_03.ogg'),T)
		update_sprite()

/obj/structure/interactive/blob/on_destruction(var/damage = TRUE)
	. = ..()
	qdel(src)

/obj/structure/interactive/blob/Cross(atom/movable/O,atom/oldloc)
	if(is_living(O))
		var/mob/living/L = O
		if(L.loyalty_tag == "Blob")
			return TRUE
	. = ..()

/obj/structure/interactive/blob/get_base_transform()
	. = ..()
	var/matrix/M = .
	M.Turn(turn_angle)