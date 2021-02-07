#define POD_IDLE 0
#define POD_PRE_LAUNCH 1
#define POD_LAUNCHING 2
#define POD_LAUNCHED 3
#define POD_LANDING 4
#define POD_LANDED 5
#define POD_OPENING 6

var/global/list/obj/structure/interactive/drop_pod/all_drop_pods = list()

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

	density = TRUE

/obj/structure/interactive/drop_pod/Cross(atom/movable/O)

	if(state == POD_IDLE)
		return TRUE

	return ..()

/obj/structure/interactive/drop_pod/Uncross(atom/movable/O)

	if(state == POD_IDLE)
		return TRUE

	return ..()

/obj/structure/interactive/drop_pod/Destroy()
	all_drop_pods -= src
	return ..()

/obj/structure/interactive/drop_pod/Finalize()
	all_drop_pods += src
	return ..()


/obj/structure/interactive/drop_pod/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(10)

	if(state == POD_IDLE) //Lets rock!
		set_state(POD_PRE_LAUNCH)
		return TRUE
	else if(state == POD_PRE_LAUNCH && (caller in contents)) //OH GOD OH FUCK CANCEL.
		set_state(POD_IDLE)
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


/obj/structure/interactive/drop_pod/proc/set_state(var/desired_state,var/turf/desired_loc) //desired_loc is optional

	if(state == desired_state)
		return FALSE

	switch(desired_state)
		if(POD_IDLE)
			icon_state = "pod"
			for(var/k in contents)
				var/atom/movable/M = k
				M.force_move(src.loc)
		if(POD_PRE_LAUNCH)
			var/turf/T = get_turf(src)
			for(var/mob/living/advanced/A in T.contents)
				if(!A.Move(src))
					continue
				state = desired_state
				icon_state = "pod_closed"
				return TRUE
			return FALSE
		if(POD_LAUNCHING)
			icon_state = "none"
			flick("drop_anim",src)
			CALLBACK("set_state_\ref[src]",3,src,.proc/set_state,POD_LAUNCHED,desired_loc)
			play_sound('sound/machines/blastdoor.ogg',get_turf(src))
		if(POD_LAUNCHED)
			icon_state = "none"
			CALLBACK("set_state_\ref[src]",20,src,.proc/set_state,POD_LANDING,desired_loc)
		if(POD_LANDING)
			force_move(desired_loc)
			pixel_z = TILE_SIZE*20
			icon_state = "pod_air"
			animate(src,pixel_z = 0,time=20)
			CALLBACK("set_state_\ref[src]",20,src,.proc/set_state,POD_LANDED,desired_loc)
			play_sound('sound/machines/droppod_landing.ogg',get_turf(src))
		if(POD_LANDED)
			icon_state = "pod_closed"
			flick("land_anim",src)
			CALLBACK("set_state_\ref[src]",50,src,.proc/set_state,POD_OPENING,desired_loc)
			explode(desired_loc,2,src,src)
		if(POD_OPENING)
			play_sound('sound/machines/droppod_land.ogg',get_turf(src))
			icon_state = "pod"
			for(var/k in contents)
				var/atom/movable/M = k
				M.force_move(src.loc)

	state = desired_state

	return TRUE