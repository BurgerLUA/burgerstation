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

	var/list/vehicle_buttons = list()

	iff_tag = "NanoTrasen"
	loyalty_tag = "NanoTrasen"

	var/list/buttons_to_add = list(
		/obj/hud/button/vehicle/eject,
		/obj/hud/button/vehicle/weapon,
		/obj/hud/button/vehicle/weapon/right
	)

/mob/living/vehicle/proc/add_buttons(var/mob/living/advanced/A)
	for(var/v in buttons_to_add)
		var/obj/hud/button/B = new v(src)
		B.update_owner(A)
	return TRUE

/mob/living/vehicle/proc/remove_buttons(var/mob/living/advanced/A)
	for(var/obj/hud/button/B in A.buttons)
		if(B.type in buttons_to_add)
			B.update_owner(null)
	return TRUE

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
		if(click_flags & RIGHT_HAND)
			if(equipment[1])
				equipment[1].click_on_object(caller,object,location,control,params)
			else
				caller.to_chat("<b>\the [src.name]</b> blares, \"No equipment found in slot 1!\"")

		if(click_flags & LEFT_HAND && equipment[2])
			if(equipment[2])
				equipment[2].click_on_object(caller,object,location,control,params)
			else
				caller.to_chat("\the [src.name] blares, \"No equipment found in slot 2!\"")
	else
		caller.to_chat("<b>\the [src.name]</b> blares, \"No equipment found!\"")

	return TRUE

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

/mob/living/vehicle/proc/enter_vehicle(atom/movable/Obj,atom/OldLoc)

	if(!is_advanced(Obj))
		return ..()

	var/mob/living/advanced/L = Obj
	L.driving = src
	passengers += L
	L.force_move(src.loc)
	if(L.client)
		L.client.eye = src
	L.invisibility = 100
	L.collision_flags = FLAG_COLLISION_NONE
	L.collision_bullet_flags = FLAG_COLLISION_BULLET_NONE
	add_buttons(L)
	L.show_hud(FALSE,FLAGS_HUD_ALL,FLAGS_HUD_WIDGET|FLAGS_HUD_SPECIAL,speed=0)
	L.show_hud(TRUE,FLAGS_HUD_VEHICLE,speed=1)
	update_sprite()

	return ..()

/mob/living/vehicle/Move(var/atom/NewLoc,Dir=0,desired_step_x=0,desired_step_y=0,var/silent=FALSE)

	. = ..()

	if(.)
		for(var/atom/movable/M in passengers)
			M.force_move(src.loc)

	return .

/mob/living/vehicle/proc/exit_vehicle(atom/movable/Obj, atom/newloc)

	if(!is_advanced(Obj))
		return ..()

	var/mob/living/advanced/L = Obj
	L.driving = null
	passengers -= L
	if(L.client)
		L.client.eye = L
	L.invisibility = initial(L.invisibility)
	remove_buttons(L)
	L.show_hud(FALSE,FLAGS_HUD_VEHICLE,speed=0)
	L.show_hud(TRUE,FLAGS_HUD_ALL,FLAGS_HUD_SPECIAL,speed=0)
	update_sprite()

	return ..()

/mob/living/vehicle/proc/can_enter_vehicle(var/mob/caller)

	if(get_dist(src,caller) > 1)
		caller.to_chat("You're too far away!")
		return FALSE

	if(length(passengers) >= passengers_max)
		caller.to_chat("\The [src.name] is full!")
		return FALSE

	if(!is_advanced(caller))
		caller.to_chat("You can't get inside \the [src.name]!")
		return FALSE

	var/mob/living/advanced/A = caller

	if(A.iff_tag != iff_tag)
		A.to_chat("ERROR: Unrecognized IFF tag.")
		return FALSE

	return TRUE

/mob/living/vehicle/clicked_on_by_object(var/mob/caller,object,location,control,params) //Enter the vehicle.

	if(!can_enter_vehicle(caller))
		return FALSE

	PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/enter_vehicle,caller)
	PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_enter_vehicle,caller)

	return TRUE