/obj/item/weapon/ranged/energy/fed  //I mean, you basically just feed it shit?
	charge_cost = 10
	battery = /obj/item/powercell/dummy

	var/charge_per_feed = 100
	var/action_name = "feed"
	var/fed_item = null
	var/feed_delay = 1

/obj/item/weapon/ranged/energy/fed/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_item(object))
		var/obj/item/I = object
		var/obj/item/weapon/ranged/energy/fed/G = object
		caller.to_chat(span("notice","Did not make it past if"))
		if(I.type == G.fed_item)
			caller.to_chat(span("notice","Made it this far"))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			battery.charge_current += G.charge_per_feed
			caller.to_chat(span("notice","You've recharged \the [src.name]."))
			qdel(object)
			return
		else
			caller.to_chat(span("warning","You can't use this for refilling!"))
			return FALSE

	if(is_item(object))
		var/obj/item/I = object
		if(I.flags_tool & FLAG_TOOL_CROWBAR)
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			INTERACT_DELAY(5)
			if(battery)
				caller.to_chat(span("warning","You are unable to pry out \the [battery.name]."))
			else
				caller.to_chat(span("warning","There is nothing to pry out of \the [src.name]!"))
			return TRUE

	. = ..()
///obj/item/weapon/ranged/energy/fed/proc/get_fed_charge_cost(