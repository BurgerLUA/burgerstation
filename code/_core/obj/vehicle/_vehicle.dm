/mob/living/vehicle/
	name = "Vehicle"
	desc = "A large vehicle that holds a driver"

	var/list/mob/living/advanced/passengers //Slot 1 is a driver.
	var/passengers_max = 1

	collision_flags = FLAG_COLLISION_WALKING
	collision_bullet_flags = FLAG_COLLISION_BULLET_INORGANIC

	opacity = 0
	anchored = FALSE

	layer = LAYER_MOB_BELOW

	var/list/obj/item/equipment = list()

	var/list/vehicle_buttons = list()

	iff_tag = "NanoTrasen"
	loyalty_tag = "NanoTrasen"

	var/list/buttons_to_add = list(
		/obj/hud/button/vehicle/eject,
		/obj/hud/button/vehicle/weapon,
		/obj/hud/button/vehicle/weapon/right,
		/obj/hud/button/vehicle/ammo_display,
		/obj/hud/button/vehicle/ammo_display/right
	)

	blood_type = null

	health = /health/mob/living/vehicle

/mob/living/vehicle/get_examine_details_list()

	. = ..()

	for(var/k in equipment)
		var/obj/item/I = k
		. += div("notice","It has \the [I.name] attached.")

	return .


/mob/living/vehicle/on_crush()

	for(var/k in passengers)
		var/mob/living/advanced/A = k
		exit_vehicle(A,loc)
		A.on_crush()

	qdel(src)

	return TRUE

/mob/living/vehicle/Destroy()

	for(var/k in passengers)
		var/mob/living/advanced/A = k
		exit_vehicle(A,loc)
	passengers.Cut()

	for(var/k in equipment)
		var/obj/item/I = k
		qdel(I)
	equipment.Cut()

	return ..()

/mob/living/vehicle/post_death()
	for(var/k in passengers)
		var/mob/living/advanced/A = k
		exit_vehicle(A, get_turf(src))
	explode(get_turf(src),2,src,src)
	return ..()

/mob/living/vehicle/proc/add_buttons(var/mob/living/advanced/A)
	for(var/v in buttons_to_add)
		var/obj/hud/button/B = new v(src)
		B.update_owner(A)
	return TRUE

/mob/living/vehicle/proc/remove_buttons(var/mob/living/advanced/A)
	for(var/k in A.buttons)
		var/obj/hud/button/B = k
		if(B.type in buttons_to_add)
			B.update_owner(null)
	return TRUE

/mob/living/vehicle/proc/attach_equipment(var/mob/caller,var/obj/item/I)
	if(I in equipment)
		return FALSE
	if(I.unremovable)
		return FALSE
	caller?.to_chat(span("notice","\The [caller.name] attaches \the [I.name] to \the [src.name]."),span("notice","You attach \the [I.name] to \the [src.name]."))
	equipment += I
	I.drop_item(src)
	I.unremovable = TRUE
	update_sprite()

/mob/living/vehicle/proc/unattach_equipment(var/mob/caller,var/obj/item/I)
	if(!(I in equipment))
		return FALSE
	caller?.visible_message(span("notice","\The [caller.name] detaches \the [I.name] from \the [src.name]."),span("notice","You detach \the [I.name] from \the [src.name]."))
	equipment -= I
	I.force_move(get_turf(caller))
	I.unremovable = initial(I.unremovable)
	update_sprite()

/mob/living/vehicle/New(var/desired_loc)
	..()
	passengers = list()
	equipment = list()
	update_sprite()


/mob/living/vehicle/proc/can_attach_weapon(var/mob/caller,var/obj/item/weapon/W)

	if(ai || length(passengers))
		caller?.to_chat(span("warning","You can't add this while it's in use!"))
		return FALSE
	if(length(equipment) >= 2)
		caller?.to_chat(span("warning","You can't fit any more weapons on \the [src.name]!."))
		return FALSE

	return TRUE

/mob/living/vehicle/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(caller == src)
		return ..()

	DEFER_OBJECT

	if(is_item(defer_object) && is_living(caller))
		var/mob/living/L = caller
		if(L.intent != INTENT_HARM)
			var/obj/item/I = defer_object
			if(I.flags_tool & FLAG_TOOL_WRENCH)
				INTERACT_CHECK
				INTERACT_CHECK_OBJECT
				INTERACT_DELAY(5)
				if(ai || length(passengers))
					caller.to_chat(span("warning","You can't remove this while it's in use!"))
					return TRUE
				if(!length(equipment))
					caller.to_chat(span("warning","There is nothing to remove from \the [src.name]!"))
					return TRUE
				var/atom/movable/choice = input("What would you like to remove?","Equipment Removal") as null|anything in equipment
				if(choice && choice in equipment)
					caller?.visible_message(span("notice","\The [caller.name] removes \the [choice.name] from \the [src.name]."),span("notice","You remove \the [choice.name] from \the [src.name]."))
					unattach_equipment(caller,choice)
				else
					caller.to_chat(span("notice","You choose not to remove anything."))
				return TRUE

			if(istype(I,/obj/item/weapon/ranged/energy/mech))
				INTERACT_CHECK
				INTERACT_CHECK_OBJECT
				INTERACT_DELAY(5)
				if(can_attach_weapon(caller,I)) attach_equipment(caller,I)
				return TRUE

	if(is_inventory(object))
		if(!can_enter_vehicle(caller))
			return TRUE
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),.proc/enter_vehicle,caller)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_enter_vehicle,caller)
		return TRUE

	return ..()

/mob/living/vehicle/can_attack(var/atom/victim,var/atom/weapon,var/params,var/damagetype/damage_type)

	if(!(get_dir(src,victim) & dir))
		return FALSE

	return ..()


/mob/living/vehicle/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_hud(object))
		return ..()

	if(!params || !length(params))
		params["right"] = rand(0,1)
		params["left"] = rand(0,1)

	if(params["left"])
		if(length(equipment) >= 1)
			equipment[1].click_on_object(caller,object,location,control,params)
		else
			src.do_say("No equipment found in slot 1!")

	if(params["right"])
		if(length(equipment) >= 2)
			equipment[2].click_on_object(caller,object,location,control,params)
		else
			src.do_say("No equipment found in slot 2!")

	return TRUE

/mob/living/vehicle/handle_movement(var/adjust_delay = 0) //Runs every tick for players. Runs every decisecond for mobs.

	if(ai)
		return ..()

	if(length(passengers) && passengers[1].move_dir && move_delay <= 0)
		var/final_movement_delay = get_movement_delay()
		move_delay = round(max(final_movement_delay,move_delay + final_movement_delay),0.1)
		glide_size = step_size/move_delay
		Move(get_step(src,passengers[1].move_dir),passengers[1].move_dir)
		return TRUE

	if(adjust_delay)
		move_delay = move_delay - adjust_delay

	return FALSE

/mob/living/vehicle/set_dir(var/desired_dir,var/force=FALSE)

	. = ..()

	if(.)
		for(var/k in passengers)
			var/mob/living/L = k
			L.set_dir(.)

	return .

/mob/living/vehicle/proc/enter_vehicle(atom/movable/Obj,atom/OldLoc)

	if(!is_advanced(Obj))
		return FALSE

	if(dead)
		to_chat(span("warning","The [src.name] is destroyed!"))
		return FALSE

	if(length(passengers) >= passengers_max)
		to_chat(span("warning","There isn't enough space inside \the [src.name] to fit [length(passengers) + 1] people!"))
		return FALSE

	var/mob/living/advanced/L = Obj
	L.driving = src
	passengers += L
	L.force_move(src.loc)
	if(L.client)
		L.client.eye = src
	L.has_footsteps = FALSE
	L.invisibility = 100
	L.update_collisions(FLAG_COLLISION_NONE,FLAG_COLLISION_BULLET_NONE)
	add_buttons(L)
	L.show_hud(FALSE,FLAGS_HUD_ALL,FLAGS_HUD_WIDGET|FLAGS_HUD_SPECIAL,speed=0)
	L.show_hud(TRUE,FLAGS_HUD_VEHICLE,speed=1)
	update_sprite()

	return ..()

/mob/living/vehicle/post_move()

	. = ..()

	for(var/k in passengers)
		var/atom/movable/M = k
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
	L.has_footsteps = initial(L.has_footsteps)
	L.update_collisions(initial(L.collision_flags),initial(L.collision_bullet_flags))
	remove_buttons(L)
	L.show_hud(FALSE,FLAGS_HUD_VEHICLE,speed=0)
	L.show_hud(TRUE,FLAGS_HUD_ALL,FLAGS_HUD_SPECIAL,speed=0)
	update_sprite()

	return ..()

/mob/living/vehicle/proc/can_enter_vehicle(var/mob/caller)

	INTERACT_CHECK_NO_DELAY(src)

	if(length(passengers) >= passengers_max)
		caller.to_chat(span("warning","\The [src.name] is full!"))
		return FALSE

	if(!is_advanced(caller))
		caller.to_chat(span("warning","You can't get inside \the [src.name]!"))
		return FALSE

	var/mob/living/advanced/A = caller

	if(A.iff_tag != iff_tag)
		A.to_chat(span("warning","ERROR: Unrecognized IFF tag."))
		return FALSE

	return TRUE