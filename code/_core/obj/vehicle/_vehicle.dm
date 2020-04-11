/mob/living/vehicle/
	name = "Vehicle"
	desc = "A large vehicle that holds a driver"

	var/mob/living/advanced/passengers //Slot 1 is a driver.
	var/passengers_max = 1

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	opacity = 0
	anchored = 0

	layer = LAYER_MOB_BELOW

	var/list/obj/item/equipment

/mob/living/vehicle/proc/attach_equipment(var/obj/item/I)
	if(I in equipment)
		return FALSE
	equipment += I
	I.force_move(src)
	I.unremovable = TRUE

/mob/living/vehicle/proc/unattach_equipment(var/obj/item/I)
	if(!(I in equipment))
		return FALSE
	equipment -= I
	I.force_move(get_turf(src))
	I.unremovable = initial(I.unremovable)

/mob/living/vehicle/New(var/desired_loc)
	..()
	passengers = list()
	equipment = list()
	update_sprite()

/mob/living/vehicle/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(!is_advanced(caller))
		return FALSE

	var/mob/living/advanced/A = caller

	var/click_flags = A.client.get_click_flags(params,TRUE)

	if(length(equipment))
		if(click_flags & RIGHT_HAND && equipment[1])
			equipment[1].click_on_object(src,object,location,control,params)

		if(click_flags & LEFT_HAND && equipment[2])
			equipment[2].click_on_object(src,object,location,control,params)

	return TRUE

/mob/living/vehicle/Enter(atom/movable/O, atom/oldloc) //When we try to enter the vehicle.

	if(!is_advanced(O))
		return FALSE

	if(length(passengers) >= passengers_max)
		return FALSE

	return ..()

/mob/living/vehicle/handle_movement(var/adjust_delay = 0) //Runs every tick for players. Runs every decisecond for mobs.

	if(length(passengers) && passengers[1].move_dir && move_delay <= 0)
		var/final_movement_delay = get_movement_delay()
		move_delay = round(max(final_movement_delay,move_delay + final_movement_delay),0.1)
		glide_size = step_size/move_delay
		Move(get_step(src,passengers[1].move_dir),passengers[1].move_dir)
		return TRUE

	if(adjust_delay)
		move_delay = move_delay - adjust_delay

	return FALSE

/mob/living/vehicle/Entered(atom/movable/Obj,atom/OldLoc)

	if(!is_advanced(Obj))
		return ..()

	var/mob/living/advanced/L = Obj
	L.driving = src
	passengers += L
	if(L.client)
		L.client.eye = src
	update_sprite()

	return ..()

/mob/living/vehicle/Exit(atom/movable/O, atom/newloc) //When we try to exit the vehicle.
	return FALSE

/mob/living/vehicle/Exited(atom/movable/Obj, atom/newloc)
	if(!is_advanced(Obj))
		return ..()

	var/mob/living/advanced/L = Obj
	L.driving = null
	passengers -= L
	if(L.client)
		L.client.eye = L
	update_sprite()

	return ..()

/mob/living/vehicle/proc/can_enter_vehicle(var/mob/caller)

	if(length(passengers) >= passengers_max)
		caller.to_chat("\The [src.name] is full!")
		return FALSE

	if(!is_advanced(caller))
		caller.to_chat("You can't get inside \the [src.name]!")
		return FALSE

	if(get_dist(src,caller) > 1)
		caller.to_chat("You're too far away!")
		return FALSE

	return TRUE


/mob/living/vehicle/clicked_on_by_object(var/mob/caller,object,location,control,params) //Enter the vehicle.

	if(!can_enter_vehicle(caller))
		return FALSE

	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),caller./Move,src)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_enter_vehicle,caller)

	return TRUE

/mob/living/vehicle/drop_on_object(caller,object,location,control,params) //Exit the vehicle.

	if(!length(passengers) || !passengers[1] || !is_living(passengers[1]) || !get_turf(object) || get_dist(src,object) > 1)
		return ..()

	var/mob/living/driver = passengers[1]

	if(caller != driver)
		return FALSE

	driver.force_move(get_turf(object))

	return TRUE

