#define GROWTH_AMOUNT 100

/obj/structure/interactive/blob/
	name = "blob piece"
	icon = 'icons/obj/structure/blob.dmi'
	var/has_damaged_state = FALSE

	var/obj/structure/interactive/blob/source_blob //The blob that created this. Core or a node.
	var/obj/structure/interactive/blob/core/linked_core
	var/list/obj/structure/interactive/blob/adjacent_blobs

	color = "#80CC2A"

	plane = PLANE_OBJ

	anchored = TRUE

	collision_flags = FLAG_COLLISION_BARICADE
	collision_bullet_flags = FLAG_COLLISION_BULLET_ORGANIC
	collision_dir = NORTH | EAST | SOUTH | WEST

	damage_type = /damagetype/blob_attack/

	health = /health/construction/
	health_base = 125

	density = TRUE

	var/health_states = 0

	var/turn_angle = 0

/obj/structure/interactive/blob/Destroy()

	source_blob = null

	if(linked_core)
		linked_core.linked_walls -= src
		linked_core.linked_nodes -= src
		linked_core = null

	for(var/k in adjacent_blobs)
		var/obj/structure/interactive/blob/B = k
		B.adjacent_blobs -= src
		adjacent_blobs -= B

	. = ..()

/obj/structure/interactive/blob/proc/grow_charge(var/obj/structure/interactive/blob/original_blob,var/obj/effect/grow_effect,var/node)

	if(src.qdeleting || !original_blob || !grow_effect || original_blob.qdeleting || grow_effect.qdeleting)
		if(grow_effect && !grow_effect.qdeleting)
			qdel(grow_effect)
		return FALSE

	var/forbidden_dir = get_dir(src,original_blob)

	health.adjust_loss_smart(brute = -20) //Heal by 10.
	update_sprite()
	grow_effect.force_move(src.loc)

	var/list/possible_options = list()
	for(var/k in adjacent_blobs)
		var/obj/structure/interactive/blob/B = k
		if(get_dir(src,B) & forbidden_dir) //This makes the blob end up being an x-pattern. It's a little annoying but there isn't anything I can do about it.
			continue
		if(B.color != color)
			continue
		possible_options |= B

	var/options = length(possible_options)

	if(options >= 2)
		var/obj/structure/interactive/blob/chosen_blob = pick(possible_options)
		CALLBACK("blob_grow_\ref[grow_effect]",1,chosen_blob,.proc/grow_charge,original_blob,grow_effect)
	else
		animate(grow_effect,alpha=0,time=10)
		queue_delete(grow_effect,20)
		for(var/d in DIRECTIONS_CARDINAL)
			var/turf/T = get_step(src,d)
			var/atom/victim = T.change_victim(src,src)
			if(!victim) //Something went wrong.
				continue
			if(istype(victim,/obj/structure/interactive/blob/) && victim.color == src.color)
				continue
			if(victim != T)
				spawn src.attack(src,victim,precise=TRUE)
			else if(T.density_north || T.density_south || T.density_east || T.density_west)
				spawn src.attack(src,T,precise=TRUE)
			else
				var/obj/structure/interactive/blob/node/found_node = locate() in range(5,T)

				var/obj/structure/interactive/blob/B
				if(found_node)
					B = new/obj/structure/interactive/blob/wall(T,linked_core)
				else
					B = new/obj/structure/interactive/blob/node(T,linked_core)
				B.color = color
				INITIALIZE(B)
				FINALIZE(B)

				var/list/direction_offsets = direction_to_pixel_offset(get_dir(T,src))
				var/matrix/M = B.get_base_transform()
				M.Scale(0.1)
				M.Translate(direction_offsets[1]*TILE_SIZE,direction_offsets[2]*TILE_SIZE)
				B.transform = M
				animate(B,transform=B.get_base_transform(),pixel_x=0,pixel_y=0,time=10)

	return TRUE

/obj/structure/interactive/blob/New(var/desired_loc,var/desired_owner)
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

	health.adjust_loss_smart(brute = health.health_current - 10)
	update_sprite()

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

/obj/structure/interactive/blob/on_damage_received(var/atom/atom_damaged,var/atom/attacker,var/atom/weapon,var/damagetype/DT,var/list/damage_table,var/damage_amount,var/critical_hit_multiplier,var/stealthy=FALSE)

	. = ..()

	if(health && health.health_current <= 0)
		qdel(src)
	else
		update_sprite()

/obj/structure/interactive/blob/on_destruction(var/mob/caller,var/damage = FALSE)
	. = ..()
	qdel(src)


/obj/structure/interactive/blob/Cross(atom/movable/O,atom/oldloc)
	if(is_living(O))
		var/mob/living/L = O
		if(L.loyalty_tag == "Blob")
			return TRUE
	return ..()

/obj/structure/interactive/blob/get_base_transform()
	. = ..()
	var/matrix/M = .
	M.Turn(turn_angle)

/obj/structure/interactive/blob/update_icon()

	. = ..()

	var/turf/T = get_turf(src)

	if(T)
		var/icon_mul = health && health_states ? FLOOR( (health.health_current / health.health_max) * health_states,1) : 0
		var/desired_state = "[initial(icon_state)]_[icon_mul]"
		if(desired_state != icon_state)
			if(icon_state != initial(icon_state))
				play_sound(pick('sound/effects/impacts/flesh_01.ogg','sound/effects/impacts/flesh_02.ogg','sound/effects/impacts/flesh_03.ogg'),T)
			icon_state = desired_state


/obj/structure/interactive/blob/update_overlays()
	. = ..()
	var/image/I = new/image(icon,"[icon_state]")
	I.appearance_flags = RESET_COLOR
	I.plane = PLANE_LIGHTING
	I.blend_mode = BLEND_MULTIPLY
	add_overlay(I)
