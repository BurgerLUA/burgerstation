var/global/list/obj/structure/interactive/drop_pod/all_drop_pods = list()
var/global/list/turf/drop_pod_turfs = list() //Drop pods that need to respawn.

/obj/structure/interactive/drop_pod
	name = "orbital drop pod"
	desc = "YEHAAAAAAAAAAAAAW."
	desc_extended = "A drop pod that drops from orbit."
	icon = 'icons/obj/structure/drop_pod.dmi'
	icon_state = "pod"

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC
	collision_dir = NORTH | EAST | WEST

	bullet_block_chance = 90

	opacity = TRUE

	var/state = POD_IDLE
	var/ttl = SECONDS_TO_DECISECONDS(30)
	interaction_flags = FLAG_INTERACTION_LIVING | FLAG_INTERACTION_NO_TURF_CHECKING

	density = TRUE

/obj/structure/interactive/drop_pod/post_move(var/atom/old_loc)

	. = ..()

	for(var/k in contents)
		var/atom/movable/M = k
		M.post_move(old_loc)



/obj/structure/interactive/drop_pod/Cross(atom/movable/O,atom/oldloc)

	if(state == POD_IDLE)
		return TRUE

	return ..()

/obj/structure/interactive/drop_pod/Uncross(atom/movable/O,atom/newloc)

	if(state == POD_IDLE)
		return TRUE

	return ..()

/obj/structure/interactive/drop_pod/PreDestroy()
	for(var/k in contents)
		var/atom/movable/M = k
		M.force_move(src.loc)
	all_drop_pods -= src
	. = ..()


/obj/structure/interactive/drop_pod/Finalize()
	all_drop_pods += src
	return ..()

/obj/structure/interactive/drop_pod/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(state == POD_IDLE) //Lets rock!
		set_state(caller,POD_PRE_LAUNCH)
		return TRUE
	else if(state == POD_PRE_LAUNCH && (caller in contents)) //OH GOD OH FUCK CANCEL.
		set_state(caller,POD_IDLE)
		return TRUE

	return ..()

/obj/structure/interactive/drop_pod/Enter(atom/movable/O, atom/oldloc)

	if(state != POD_IDLE)
		return FALSE

	return ..()

/obj/structure/interactive/drop_pod/Exit(atom/movable/O, atom/newloc)

	if(state != POD_OPENING)
		return FALSE

	return ..()


/obj/structure/interactive/drop_pod/proc/set_state(var/mob/caller,var/desired_state,var/turf/desired_loc) //desired_loc is optional, same with caller.

	if(state == desired_state)
		return FALSE

	if(caller && !is_advanced(caller))
		return FALSE

	switch(desired_state)
		if(POD_IDLE) //Pod is set to IDLE if whoever is inside it cancels.
			icon_state = "pod"
			for(var/k in contents) //Eject everything.
				var/atom/movable/M = k
				M.force_move(src.loc)
		if(POD_PRE_LAUNCH) //Someone tries to move inside.
			if(!caller || caller.loc != src.loc)
				return FALSE
			var/obj/hud/button/map_background/M_background = locate() in caller.buttons
			if(M_background)
				caller.to_chat(span("warning","Close your current map to enter \the [src.name]!"))
				return FALSE
			if(!caller.Move(src))
				return FALSE
			M_background = new(caller,desired_pod=src)
			M_background.update_owner(caller)
			icon_state = "pod_closed"
		if(POD_LAUNCHING) //IT BEGINS. We're launching now.
			if(!SSgamemode.active_gamemode.allow_launch)
				caller.to_chat(span("warning","Invalid drop location: NanoTrasen has deemed it's unsafe to launch at this time!"))
				return FALSE
			if(!desired_loc)
				caller.to_chat(span("warning","Invalid drop location: No drop location selected."))
				return FALSE
			for(var/d in DIRECTIONS_ALL)
				var/turf/T = get_step(desired_loc,d)
				if(!T || T.has_dense_atom)
					caller.to_chat(span("warning","Invalid drop location: Target area is obstructed."))
					return FALSE
				if(!T.is_safe() || !T.can_move_to())
					caller.to_chat(span("warning","Invalid drop location: Unsafe area."))
					return FALSE
				var/area/A = T.loc
				if(A.interior)
					caller.to_chat(span("warning","Invalid drop location: Target area is obstructed."))
					return FALSE
			icon_state = "none"
			flick("drop_anim",src)
			CALLBACK("set_state_\ref[src]",3,src,src::set_state(),caller,POD_LAUNCHED,desired_loc)
			play_sound('sound/machines/blastdoor.ogg',get_turf(src))
		if(POD_LAUNCHED)
			icon_state = "none"
			CALLBACK("set_state_\ref[src]",20,src,src::set_state(),caller,POD_LANDING,desired_loc)
		if(POD_LANDING)
			drop_pod_turfs += get_turf(src)
			force_move(desired_loc)
			pixel_z = TILE_SIZE*20
			icon_state = "pod_air"
			animate(src,pixel_z = 0,time=20)
			CALLBACK("set_state_\ref[src]",20,src,src::set_state(),caller,POD_LANDED,desired_loc)
			play_sound('sound/machines/droppod_landing.ogg',get_turf(src))
		if(POD_LANDED)
			icon_state = "pod_closed"
			flick("land_anim",src)
			CALLBACK("set_state_\ref[src]",50,src,src::set_state(),caller,POD_OPENING,desired_loc)
			explode(desired_loc,3,src,src,"NanoTrasen")
		if(POD_OPENING)
			play_sound('sound/machines/droppod_land.ogg',get_turf(src))
			icon_state = "pod"
			for(var/k in contents)
				var/atom/movable/M = k
				M.force_move(src.loc)
			CALLBACK("set_state_\ref[src]",ttl,src,src::set_state(),caller,POD_DESTROY,desired_loc)
		if(POD_DESTROY)
			qdel(src)
	state = desired_state

	return TRUE