/obj/item/grenade/
	name = "grenade"
	desc = "Activate, then throw."
	desc_extended = "With good grenades being expensive and hard to come by, civilians often use homemade grenades filled with various chemicals, with varying degrees of success."

	can_rename = TRUE

	var/list/obj/item/container/simple/beaker/stored_containers = list()
	var/obj/item/device/stored_trigger

	reagents = /reagent_container/grenade

	var/max_containers = 2

	var/open = TRUE

	queue_delete_immune = TRUE

	weight = 1

	var/spent = FALSE

	has_quick_function = TRUE

	rarity = RARITY_UNCOMMON

	thrown_bounce_modifier = 1

	size = SIZE_1

/obj/item/grenade/get_base_value()
	. = max_containers*75
	. *= 0.5 + (size/SIZE_2)*0.5
	if(spent)
		. *= 0.1

/obj/item/grenade/get_projectile_offset(var/initial_offset_x,var/initial_offset_y,var/bullet_num,var/bullet_num_max,var/accuracy)

	var/num = bullet_num/bullet_num_max

	var/norm_x = sin(num*360)
	var/norm_y = cos(num*360)

	var/mul = max(abs(norm_x),abs(norm_y))

	return list(norm_x/mul,norm_y/mul)

/obj/item/grenade/PreDestroy()
	QDEL_NULL(stored_trigger)
	QDEL_CUT(stored_containers)
	. = ..()

/obj/item/grenade/Finalize()
	. = ..()
	update_sprite()

/obj/item/grenade/quick(var/mob/caller,var/atom/object,location,params)

	if(!is_living(caller) || !object)
		return FALSE

	var/mob/living/L = caller
	var/vel_x = object.x - L.x
	var/vel_y = object.y - L.y
	var/highest = max(abs(vel_x),abs(vel_y))

	if(!highest)
		src.drop_item(get_turf(L)) //Drop if we can't throw.
		return TRUE

	vel_x *= 1/highest
	vel_y *= 1/highest

	vel_x *= BULLET_SPEED_LARGE_PROJECTILE
	vel_y *= BULLET_SPEED_LARGE_PROJECTILE

	src.click_self(caller)
	src.drop_item(get_turf(L),silent=TRUE)
	src.throw_self(
		L,
		get_turf(object),
		params[PARAM_ICON_X],
		params[PARAM_ICON_Y],
		vel_x,
		vel_y,
		steps_allowed = VIEW_RANGE,
		lifetime = 10,
		desired_loyalty_tag = L.loyalty_tag
	)

	return TRUE

/obj/item/grenade/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE,var/loadout=FALSE)
	RUN_PARENT_SAFE
	SAVEVAR("open")
	SAVEVAR("spent")
	SAVEATOM("stored_trigger")
	SAVELISTATOM("stored_containers")

/obj/item/grenade/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data,var/loadout=FALSE)
	RUN_PARENT_SAFE
	LOADVAR("open")
	LOADVAR("spent")
	LOADATOM("stored_trigger")
	LOADLISTATOM("stored_containers")

/obj/item/grenade/post_move(var/atom/old_loc)

	. = ..()

	if(stored_trigger?.active && (!old_loc || !is_turf(old_loc) || !is_turf(loc) || old_loc.z != loc.z))

		if(is_turf(old_loc) && SSai.tracked_avoidance_by_z["[old_loc.z]"])
			SSai.tracked_avoidance_by_z["[old_loc.z]"] -= src

		if(is_turf(loc))
			if(!SSai.tracked_avoidance_by_z["[loc.z]"])
				SSai.tracked_avoidance_by_z["[loc.z]"] = list()
			SSai.tracked_avoidance_by_z["[loc.z]"] += src


/obj/item/grenade/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty_tag)

	if(alpha == 0) //Already gone.
		return FALSE

	if(source == src)
		if(!src.z) drop_item(get_turf(src))
		if(stored_trigger) stored_trigger.active = FALSE
	else
		trigger(owner,source,-1,-1)

	alpha = 0
	mouse_opacity = 0
	anchored = 2

/obj/item/grenade/New(var/desired_loc)
	. = ..()
	update_sprite()

/obj/item/grenade/Generate()

	. = ..()

	for(var/k in stored_containers)
		var/obj/item/I = k
		INITIALIZE(I)
		GENERATE(I)
		FINALIZE(I)

	if(stored_trigger)
		INITIALIZE(stored_trigger)
		GENERATE(stored_trigger)
		FINALIZE(stored_trigger)

	update_sprite()


/obj/item/grenade/update_icon()

	if(spent)
		icon_state = "[initial(icon_state)]_spent"
	else if(length(stored_containers) && stored_trigger)
		if(stored_trigger.active)
			icon_state = "[initial(icon_state)]_active"
		else
			icon_state = initial(icon_state)
	else if(length(stored_containers) || stored_trigger)
		icon_state = "[initial(icon_state)]_assembly"
	else
		icon_state = "[initial(icon_state)]_casing"

	return ..()

/obj/item/grenade/click_self(var/mob/caller,location,control,params)

	if(spent)
		return ..()

	INTERACT_CHECK

	if(stored_trigger)
		stored_trigger.click_self(caller)

	last_interacted = caller

	update_sprite()

	return TRUE

/obj/item/grenade/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(spent)
		return ..()

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_SCREWDRIVER)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(max_containers <= 0)
				caller.to_chat(span("warning","There is nothing to unscrew on \the [src.name]!"))
				return TRUE
			open = !open
			caller.to_chat(span("notice","You [open ? "unscrew" : "screw"] the screws on \the [src.name], [open ? "unsecuring" : "securing"] it."))
			return TRUE
		else if(I.reagents && I.allow_reagent_transfer_from)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(!open)
				if(max_containers > 0)
					caller.to_chat(span("warning","\The [src.name] needs to be unscrewed with a screwdriver before you add containers!"))
				return TRUE
			if(length(stored_containers) >= max_containers)
				caller.to_chat(span("warning","You can't fit any more contains in \the [src.name]!"))
				return TRUE
			var/obj/item/container/simple/B = object
			if(B.size > src.size)
				caller.to_chat(span("warning","\The [B.name] is too large to be put into \the [src.name]!"))
				return TRUE
			B.drop_item(src)
			stored_containers += B
			caller.visible_message(span("notice","\The [caller.name] fits \the [object.name] into \the [src.name]."),span("notice","You fit \the [object.name] inside \the [src.name]."))
			update_sprite()
			return TRUE
		else if(istype(object,/obj/item/device/))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(!open)
				caller.to_chat(span("warning","\The [src.name] needs to be unscrewed with a screwdriver before you add trigger devices!"))
				return TRUE
			if(stored_trigger)
				caller.to_chat(span("warning","There is already a [stored_trigger.name] inside \the [src.name]!"))
				return TRUE
			var/obj/item/device/T = object
			if(T.size > src.size)
				caller.to_chat(span("warning","\The [T.name] is too large to be put into \the [src.name]!"))
				return TRUE
			T.drop_item(src)
			stored_trigger = T
			caller.visible_message(span("notice","\The [caller.name] fits \the [object.name] into \the [src.name]."),span("notice","You fit \the [object.name] inside \the [src.name]."))
			update_sprite()
			return TRUE
	else if(is_inventory(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		if(!open)
			caller.to_chat(span("warning","\The [src.name] needs to be unscrewed with a screwdriver before you remove its contents!"))
			return TRUE
		var/obj/hud/inventory/I = object
		if(length(stored_containers))
			var/obj/item/container/simple/beaker/selected_beaker = stored_containers[length(stored_containers)]
			if(I.add_object(selected_beaker))
				caller.visible_message(span("notice","\The [caller.name] removes \the [selected_beaker.name] from \the [src.name]."),span("notice","You remove \the [selected_beaker.name] from \the [src.name]."))
				stored_containers -= selected_beaker
				update_sprite()
			else
				caller.to_chat(span("warning","You need an empty hand in ordet to remove \the [selected_beaker.name]!"))
		else if(stored_trigger)
			if(stored_trigger.active)
				caller.to_chat(span("danger","You must defuse \the [stored_trigger.name] first before removing \the [stored_trigger.name]!"))
				return TRUE
			else if(I.add_object(stored_trigger))
				caller.visible_message(span("notice","\The [caller.name] removes \the [stored_trigger.name] from \the [src.name]."),span("notice","You remove \the [stored_trigger.name] from \the [src.name]."))
				stored_trigger = null
				update_sprite()
			else
				caller.to_chat(span("warning","You need an empty hand in ordet to remove \the [stored_trigger.name]!"))
		else
			caller.to_chat(span("warning","There is nothing to remove from \the [src.name]!"))
		return TRUE

	return ..()

/obj/item/grenade/trigger(var/mob/caller,var/atom/source,var/signal_freq,var/signal_code)

	if(is_inventory(loc))
		drop_item()

	if(istype(loc,/obj/projectile/))
		var/obj/projectile/P = loc
		var/turf/T = get_turf(src)
		P.on_projectile_hit(T)
		qdel(P)

	if(src.loc && is_turf(src.loc) && SSai.tracked_avoidance_by_z["[src.loc.z]"])
		SSai.tracked_avoidance_by_z["[src.loc.z]"] -= src

	for(var/k in stored_containers)
		var/obj/item/container/simple/beaker/B = k
		B.reagents.transfer_reagents_to(src.reagents,B.reagents.volume_current,FALSE,FALSE, caller = caller)
		B.reagents.update_container(caller)
		B.reagents.process_recipes(caller)

	spent = TRUE

	if(src.reagents)
		src.reagents.update_container(caller)
		src.reagents.process_recipes(caller)

	update_sprite()

	. = ..()