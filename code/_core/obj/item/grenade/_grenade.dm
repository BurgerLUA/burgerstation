/obj/item/grenade/
	name = "grenade"
	desc = "Activate, then throw."

	icon = 'icons/obj/items/grenade.dmi'
	icon_state = "chem"

	var/list/obj/item/container/beaker/stored_containers = list()
	var/obj/item/trigger/stored_trigger

	reagents = /reagent_container/grenade

	var/max_containers = 2

	var/open = TRUE

/obj/item/grenade/New(var/desired_loc)
	. = ..()
	update_icon()
	return .


/obj/item/grenade/update_icon()

	if(length(stored_containers) && stored_trigger)
		icon_state = "chem"
	else if(length(stored_containers) || stored_trigger)
		icon_state = "chem_assembly"
	else
		icon_state = "chem_casing"

	return ..()

/obj/item/grenade/click_self(var/atom/caller)

	if(stored_trigger)
		stored_trigger.click_self(caller)

	return TRUE

/obj/item/grenade/clicked_on_by_object(var/mob/caller as mob,var/atom/object,location,control,params)

	object = object.defer_click_on_object()

	if(open)
		if(is_inventory(object))
			var/obj/hud/inventory/I = object

			if(length(stored_containers))
				var/obj/item/container/beaker/selected_beaker = stored_containers[length(stored_containers)]
				if(I.add_held_object(selected_beaker))
					caller.to_chat(span("notice","You remove \the [selected_beaker.name] from \the [src.name]."))
					stored_containers -= selected_beaker
					update_icon()
				else
					caller.to_chat(span("notice","You need an empty hand in ordet to remove \the [selected_beaker.name]!"))

				return TRUE

			if(stored_trigger)
				if(I.add_held_object(stored_trigger))
					caller.to_chat(span("notice","You remove \the [stored_trigger.name] from \the [src.name]."))
					stored_trigger = null
					update_icon()
				else
					caller.to_chat(span("notice","You need an empty hand in ordet to remove \the [stored_trigger.name]!"))

				return TRUE

		else if(is_beaker(object))
			if(length(stored_containers) < max_containers)
				var/obj/item/container/beaker/B = object
				B.drop_item(src)
				B.force_move(src)
				stored_containers += B
				caller.to_chat(span("notice","You fit \the [object.name] inside \the [src.name]."))
				update_icon()
			else
				caller.to_chat(span("notice","You can't fit \the [object.name] in!"))



			return TRUE

		else if(is_trigger(object))
			if(!stored_trigger)
				var/obj/item/trigger/T = object
				T.drop_item(src)
				T.force_move(src)
				stored_trigger = T
				caller.to_chat(span("notice","You fit \the [object.name] inside \the [src.name]."))
				update_icon()
			else
				caller.to_chat(span("notice","You can't fit \the [object.name] in!"))

			return TRUE

	return ..()


/obj/item/grenade/trigger(var/atom/source,var/signal_freq,var/signal_code)

	for(var/obj/item/container/beaker/B in stored_containers)
		B.reagents.transfer_reagents_to(src.reagents,B.reagents.volume_current,FALSE,FALSE)
		B.reagents.update_container()

	src.reagents.update_container()
	src.reagents.process_recipes()

	return TRUE