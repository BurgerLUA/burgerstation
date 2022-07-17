/obj/item/grenade/
	name = "grenade"
	desc = "Activate, then throw."
	desc_extended = "With good grenades being expensive and hard to come by, civilians often use homemade grenades filled with various chemicals, with varying degrees of success."

	can_rename = TRUE

	icon = 'icons/obj/item/grenade.dmi'
	icon_state = "chem"

	var/list/obj/item/container/simple/beaker/stored_containers = list()
	var/obj/item/device/stored_trigger

	reagents = /reagent_container/grenade

	var/max_containers = 2

	var/open = TRUE

	value = 15

	queue_delete_immune = TRUE

	weight = 1

	var/spent=FALSE

	has_quick_function = TRUE


/obj/item/grenade/get_projectile_offset(var/initial_offset_x,var/initial_offset_y,var/bullet_num,var/bullet_num_max,var/accuracy)

	var/num = bullet_num/bullet_num_max

	var/norm_x = sin(num*360)
	var/norm_y = cos(num*360)

	var/mul = max(abs(norm_x),abs(norm_y))

	return list(norm_x/mul,norm_y/mul)

/obj/item/grenade/Destroy()

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
		lifetime = 30,
		desired_loyalty_tag = L.loyalty_tag
	)

	return TRUE

/obj/item/grenade/save_item_data(var/mob/living/advanced/player/P,var/save_inventory = TRUE,var/died=FALSE)
	. = ..()
	SAVEVAR("open")
	SAVEVAR("spent")
	SAVEATOM("stored_trigger")
	SAVELISTATOM("stored_containers")

/obj/item/grenade/load_item_data_pre(var/mob/living/advanced/player/P,var/list/object_data)
	. = ..()
	LOADVAR("open")
	LOADVAR("spent")
	LOADATOM("stored_trigger")
	LOADLISTATOM("stored_containers")

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

/obj/item/grenade/click_self(var/mob/caller)

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
			open = !open
			caller.to_chat(span("notice","You [open ? "unscrew" : "screw"] the screws on \the [src.name], [open ? "unsecuring" : "securing"] it."))
			return TRUE
		else if(I.reagents && I.allow_reagent_transfer_from)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(!open)
				caller.to_chat(span("warning","\The [src.name] needs to be unscrewed with a screwdriver before you add containers!"))
				return TRUE
			if(length(stored_containers) >= max_containers)
				caller.to_chat(span("warning","You can't fit any more contains in \the [src.name]!"))
				return TRUE
			var/obj/item/container/simple/B = object
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
			if(I.add_object(stored_trigger))
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

	if(!src.reagents)
		return ..()

	if(is_inventory(loc))
		drop_item()

	if(istype(loc,/obj/projectile/))
		var/obj/projectile/P = loc
		var/turf/T = get_turf(src)
		P.on_projectile_hit(T)
		qdel(P)

	for(var/k in stored_containers)
		var/obj/item/container/simple/beaker/B = k
		B.reagents.transfer_reagents_to(src.reagents,B.reagents.volume_current,FALSE,FALSE, caller = caller)
		B.reagents.update_container()

	spent = TRUE

	src.reagents.update_container()
	src.reagents.process_recipes(caller)

	update_sprite()

	. = ..()

/obj/item/grenade/timed/Generate()
	var/obj/item/device/timer/T = new(src)
	T.time_set = 30
	stored_trigger = T
	open = FALSE
	return ..()

/obj/item/grenade/timed/explosive
	name = "timed explosive grenade"
	desc = "Kaboom!"
	desc_extended = "A prebuilt timed explosive grenade. The labeling indicates that the fuse is set to 3 seconds."

/obj/item/grenade/timed/explosive/Generate()
	stored_containers += new /obj/item/container/simple/beaker/water(src)
	stored_containers += new /obj/item/container/simple/beaker/potassium(src)
	return ..()

/obj/item/grenade/timed/explosive_large
	name = "timed large explosive grenade"
	desc = "Kaboom!"
	desc_extended = "A prebuilt timed explosive grenade. The labeling indicates that the fuse is set to 3 seconds. This one has a larger payload."

/obj/item/grenade/timed/explosive_large/Generate()
	stored_containers += new /obj/item/container/simple/beaker/large/water(src)
	stored_containers += new /obj/item/container/simple/beaker/large/potassium(src)
	return ..()

/obj/item/grenade/timed/smoke/
	name = "timed smoke grenade"
	desc = "Kaboomish!"
	desc_extended = "A prebuilt timed smoke grenade. The labeling indicates that the fuse is set to 3 seconds."

/obj/item/grenade/timed/smoke/Generate()
	stored_containers += new /obj/item/container/simple/beaker/smoke_01(src)
	stored_containers += new /obj/item/container/simple/beaker/smoke_02(src)
	return ..()

/obj/item/grenade/timed/lube_smoke
	name = "timed lube smoke grenade"
	desc = "Kaboomish!"
	desc_extended = "A prebuilt timed lube smoke grenade. The labeling indicates that the fuse is set to 3 seconds."

/obj/item/grenade/timed/lube_smoke/Generate()
	stored_containers += new /obj/item/container/simple/beaker/large/lube_smoke_01(src)
	stored_containers += new /obj/item/container/simple/beaker/large/lube_smoke_02(src)
	return ..()