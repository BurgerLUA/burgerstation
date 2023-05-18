/obj/hud/button/lockpicking
	name = "lock"
	icon = 'icons/hud/lockpicking.dmi'
	icon_state = "base"
	screen_loc = "CENTER:-64,CENTER:-64"

	var/lock_angle = 0 //Angle of the lock itself. Determined by holding down mouse1.
	var/pick_angle = 0 //Angle of the lockpick. Determined by mouse coordinates.

	var/sweet_spot = 0 //The angle of the sweet spot.
	var/difficulty = 10 //Difficulty of the lock. Smaller is harder.

	var/obj/linked_lock
	var/obj/linked_pick
	var/obj/linked_wedge

	var/obj/structure/interactive/crate/chest/associated_chest

	plane = PLANE_HUD
	layer = LAYER_HUD + 100

	var/frozen = FALSE

/obj/hud/button/lockpicking/PreDestroy()
	QDEL_NULL(linked_lock)
	QDEL_NULL(linked_pick)
	QDEL_NULL(linked_wedge)
	. = ..()

/obj/hud/button/lockpicking/Destroy()
	associated_chest = null
	. = ..()

/obj/hud/button/lockpicking/update_owner(var/mob/desired_owner)

	. = ..()

	if(.)
		for(var/k in vis_contents)
			vis_contents -= k
		QDEL_NULL(linked_lock)
		QDEL_NULL(linked_pick)
		QDEL_NULL(linked_wedge)

		linked_lock = new(src)
		linked_lock.icon = initial(icon)
		linked_lock.icon_state = "lock"
		linked_lock.plane = plane
		linked_lock.layer = layer+1
		linked_lock.mouse_opacity = 0
		vis_contents += linked_lock

		linked_pick = new(src)
		linked_pick.icon = initial(icon)
		linked_pick.icon_state = "pick"
		linked_pick.plane = plane
		linked_pick.layer = layer+2
		linked_pick.mouse_opacity = 0
		linked_pick.pixel_y = 20
		vis_contents += linked_pick

		linked_wedge = new(src)
		linked_wedge.icon = initial(icon)
		linked_wedge.icon_state = "wedge"
		linked_wedge.plane = plane
		linked_wedge.layer = layer+3
		linked_wedge.mouse_opacity = 0
		vis_contents += linked_wedge

/obj/hud/button/lockpicking/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)
	return TRUE

/obj/hud/button/lockpicking/MouseDown(location,control,params)
	if(!frozen)
		START_THINKING(src)
	return TRUE

/obj/hud/button/lockpicking/MouseMove(location,control,params)

	. = ..()

	if(!frozen && linked_pick)
		var/list/new_params = params2list(params)
		new_params[PARAM_ICON_X] = text2num(new_params[PARAM_ICON_X])
		new_params[PARAM_ICON_Y] = text2num(new_params[PARAM_ICON_Y])

		var/icon_x = new_params[PARAM_ICON_X] - 80
		var/icon_y = new_params[PARAM_ICON_Y] - 80

		icon_y = max(1,icon_y)

		pick_angle = ATAN2(icon_x,icon_y)

		pick_angle = clamp(pick_angle,1,179)

		var/matrix/M = matrix()
		M.Turn(90 - pick_angle)
		linked_pick.transform = M

/obj/hud/button/lockpicking/think()

	if(!linked_lock || !owner)
		lock_angle = 0
		return FALSE

	if(owner.attack_flags & (CONTROL_MOD_LEFT | CONTROL_MOD_RIGHT))
		lock_angle += 10
	else
		lock_angle -= 20

	lock_angle = clamp(lock_angle,0,90)

	var/complete_multiplier = lock_angle/90 // 1 means we've unlocked it.
	var/angle_distance = abs(sweet_spot-pick_angle) //How far are we, in angular units, are we from the sweet spot?
	//The larger the angle distance, the easier it is to fail.

	var/failing = (angle_distance * complete_multiplier) > difficulty

	var/matrix/M = matrix()
	M.Turn(lock_angle)
	animate(linked_lock,transform = M,time=1)

	var/pick_x = sin(lock_angle)*15
	var/pick_y = 20 + cos(lock_angle)*15 - 15
	if(failing)
		pick_x += pick(-1,1)
		pick_y += pick(-1,1)
		lock_angle -= 15
		play_sound(pick('sound/effects/lockpicking/pick_01.ogg','sound/effects/lockpicking/pick_02.ogg','sound/effects/lockpicking/pick_03.ogg'),get_turf(owner),volume=75,pitch=RAND_PRECISE(1.25,1.5))

	animate(linked_pick,pixel_x = pick_x, pixel_y = pick_y,time= failing ? 0.1 : 1)

	var/wedge_x = -sin(lock_angle)*15
	var/wedge_y = -cos(lock_angle)*15 + 15

	animate(linked_wedge,pixel_x = wedge_x, pixel_y = wedge_y,time=1)

	if(complete_multiplier <= 0)
		lock_angle = 0
		return FALSE

	if(complete_multiplier >= 1)
		frozen = TRUE
		play_sound('sound/effects/lockpicking/lock_unlock.ogg',get_turf(owner))
		if(associated_chest)
			CALLBACK("picked_delay_\ref[src]",SECONDS_TO_DECISECONDS(2),associated_chest,/obj/structure/interactive/crate/chest/proc/picked,owner)
		return FALSE

	return TRUE