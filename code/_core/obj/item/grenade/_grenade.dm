/obj/item/grenade/
	name = "grenade"
	desc = "Activate, then throw."
	desc_extended = "With good grenades being expensive and hard to come by, civilians often use homemade grenades filled with various chemicals, with varying degrees of success."

	icon = 'icons/obj/item/grenade.dmi'
	icon_state = "chem"

	var/list/obj/item/container/beaker/stored_containers = list()
	var/obj/item/device/stored_trigger

	reagents = /reagent_container/grenade

	var/max_containers = 2

	var/open = TRUE

	value = 15

	queue_delete_immune = TRUE

	weight = 1

/obj/item/grenade/Destroy()

	QDEL_NULL(stored_trigger)

	for(var/k in stored_containers)
		var/obj/item/I = k
		qdel(I)
	stored_containers.Cut()

	return ..()

/obj/item/grenade/save_item_data(var/save_inventory = TRUE)

	. = ..()

	if(stored_trigger) .["stored_trigger"] = stored_trigger.save_item_data(save_inventory)

	if(length(stored_containers))
		.["stored_containers"] = list()
		for(var/k in stored_containers)
			var/obj/item/container/beaker/B = k
			.["stored_containers"] += list(B.save_item_data(save_inventory))

	return .

/obj/item/grenade/load_item_data_post(var/mob/living/advanced/player/P,var/list/object_data)

	. = ..()

	if(object_data["stored_trigger"]) stored_trigger = load_and_create(P,object_data["stored_trigger"],src)

	if(length(object_data["stored_containers"]))
		for(var/k in object_data["stored_containers"])
			stored_containers += load_and_create(P,k,src)

	return .

/obj/item/grenade/act_explode(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty)

	if(alpha == 0)
		return FALSE

	if(source == src)
		alpha = 0
		mouse_opacity = 0
		queue_delete_immune = FALSE
		queue_delete(src,60)
		if(!isturf(src.loc)) drop_item(get_turf(src))
		if(stored_trigger) stored_trigger.active = FALSE
	else
		trigger(owner,source,-1,-1)

	return .

/obj/item/grenade/New(var/desired_loc)
	. = ..()
	update_sprite()
	return .

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

	return .

/obj/item/grenade/update_icon()

	if(length(stored_containers) && stored_trigger)
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

	INTERACT_CHECK

	if(stored_trigger)
		stored_trigger.click_self(caller)

	last_interacted = caller

	update_sprite()

	return TRUE

/obj/item/grenade/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)



	if(!open)
		return ..()

	if(is_inventory(object))
		var/obj/hud/inventory/I = object

		if(length(stored_containers))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			var/obj/item/container/beaker/selected_beaker = stored_containers[length(stored_containers)]
			if(I.add_object(selected_beaker))
				caller.visible_message(span("notice","\The [caller.name] removes \the [selected_beaker.name] from \the [src.name]."),span("notice","You remove \the [selected_beaker.name] from \the [src.name]."))
				stored_containers -= selected_beaker
				update_sprite()
			else
				caller.to_chat(span("warning","You need an empty hand in ordet to remove \the [selected_beaker.name]!"))
			return TRUE

		if(stored_trigger)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(I.add_object(stored_trigger))
				caller.visible_message(span("notice","\The [caller.name] removes \the [stored_trigger.name] from \the [src.name]."),span("notice","You remove \the [stored_trigger.name] from \the [src.name]."))
				stored_trigger = null
				update_sprite()
			else
				caller.to_chat(span("warning","You need an empty hand in ordet to remove \the [stored_trigger.name]!"))
			return TRUE

	else if(is_beaker(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		if(length(stored_containers) >= max_containers)
			caller.to_chat(span("warning","You can't fit \the [object.name] in!"))
			return TRUE
		var/obj/item/container/beaker/B = object
		B.drop_item(src)
		stored_containers += B
		caller.visible_message(span("notice","\The [caller.name] fits \the [object.name] into \the [src.name]."),span("notice","You fit \the [object.name] inside \the [src.name]."))
		update_sprite()
		return TRUE

	else if(is_trigger(object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		INTERACT_DELAY(5)
		if(stored_trigger)
			caller.to_chat(span("warning","There is already a [stored_trigger.name] inside \the [src.name]!"))
			return TRUE
		var/obj/item/device/T = object
		T.drop_item(src)
		stored_trigger = T
		caller.visible_message(span("notice","\The [caller.name] fits \the [object.name] into \the [src.name]."),span("notice","You fit \the [object.name] inside \the [src.name]."))
		update_sprite()
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
		P.damage_atom(T)
		P.on_hit(T,TRUE)

	for(var/k in stored_containers)
		var/obj/item/container/beaker/B = k
		B.reagents.transfer_reagents_to(src.reagents,B.reagents.volume_current,FALSE,FALSE, caller = caller)
		B.reagents.update_container()

	src.reagents.update_container()
	src.reagents.process_recipes(caller)

	return ..()

/obj/item/grenade/timed/Generate()
	var/obj/item/device/timer/T = new(src)
	T.time_set = 30
	stored_trigger = T
	open = FALSE
	return ..()

/obj/item/grenade/timed/explosive/
	name = "timed explosive grenade"
	desc = "Kaboom!"
	desc_extended = "A prebuilt timed explosive grenade. The labeling indicates that the fuse is set to 3 seconds."

/obj/item/grenade/timed/explosive/Generate()
	stored_containers += new /obj/item/container/beaker/large/grenade_water(src)
	stored_containers += new /obj/item/container/beaker/large/grenade_potassium(src)
	return ..()