/obj/item/analyzer
	name = "analyzer"
	var/next_scan = 0
	value = 10

/obj/item/analyzer/proc/on_scan(var/mob/caller,var/atom/target,location,control,params)


	return TRUE


/obj/item/analyzer/proc/can_be_scanned(var/mob/caller,var/atom/target)
	return TRUE

/obj/item/analyzer/proc/can_scan(var/mob/caller,var/atom/target)
	if(next_scan >= world.time)
		caller.to_chat("\The [src.name] is recharging, please wait!")
		return FALSE
	return TRUE

/obj/item/analyzer/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(can_be_scanned(caller,object))
		if(can_scan(caller,object))
			on_scan(caller,object,location,control,params)
		return TRUE

	return ..()

