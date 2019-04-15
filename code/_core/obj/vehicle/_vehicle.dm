/obj/vehicle/
	name = "Vehicle"
	desc = "A large vehicle that holds a driver"

	var/mob/living/advanced/passengers //Slot 1 is a driver.
	var/passengers_max = 1

	density = 0
	opacity = 0
	anchored = 0

	layer = LAYER_OBJ_VEHICLE

	var/list/obj/item/equipment

/obj/vehicle/proc/attach_equipment(var/obj/item/I)
	equipment += I
	I.force_move(src)

/obj/vehicle/New(var/desired_loc)
	..()
	passengers = list()
	equipment = list()
	update_icon()

/obj/vehicle/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

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

/obj/vehicle/Enter(atom/movable/O, atom/oldloc) //When we try to enter the vehicle.

	if(!is_advanced(O))
		return FALSE

	if(length(passengers) >= passengers_max)
		return FALSE

	return ..()

/obj/vehicle/handle_movement(var/adjust_delay = 0) //Runs every decisecond

	if(length(passengers) && passengers[1].move_dir && move_delay <= 0)
		var/final_movement_delay = get_movement_delay()

		move_delay = round(max(final_movement_delay,move_delay + final_movement_delay),0.1)
		glide_size = step_size/move_delay

		Move(get_step(src,passengers[1].move_dir),passengers[1].move_dir)

		return TRUE
	else
		if(adjust_delay)
			move_delay = move_delay - adjust_delay
		return FALSE

/obj/vehicle/Entered(atom/movable/Obj,atom/OldLoc)

	if(!is_advanced(Obj))
		return ..()

	var/mob/living/advanced/L = Obj
	L.driving = src
	passengers += L
	if(L.client)
		L.client.eye = src
	update_icon()

	return ..()

/obj/vehicle/Exit(atom/movable/O, atom/newloc) //When we try to exit the vehicle.
	return FALSE

/obj/vehicle/Exited(atom/movable/Obj, atom/newloc)
	if(!is_advanced(Obj))
		return ..()

	var/mob/living/advanced/L = Obj
	L.driving = null
	passengers -= L
	if(L.client)
		L.client.eye = L
	update_icon()

	return ..()


/obj/vehicle/clicked_by_object(var/mob/caller,object,location,control,params) //Enter the vehicle.

	if(!is_living(caller) || get_dist(caller,src) > 1)
		return ..()

	var/list/callback_list = list()
	callback_list["vehicle"] = src
	callback_list["start_turf"] = get_turf(caller)
	add_progress_bar(caller,"enter_vehicle",10,callback_list)

	return TRUE

/obj/vehicle/drop_on_object(caller,object) //Exit the vehicle.

	if(!length(passengers) || !passengers[1] || !is_living(passengers[1]) || !get_turf(object) || get_dist(src,object) > 1)
		return ..()

	var/mob/living/driver = passengers[1]

	if(caller != driver)
		return FALSE

	driver.force_move(get_turf(object))

	return TRUE

