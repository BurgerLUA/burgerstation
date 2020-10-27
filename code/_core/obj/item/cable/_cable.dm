/obj/item/cable
	name = "cable"
	icon_state = "inventory"
	icon = 'icons/obj/item/cable.dmi'

	item_count_current = 1
	item_count_max = 50

	var/heal_burn = 30 //Only applies to inorganics.
	var/heal_burn_percent = 5 //Only applies to inorganics.

	value = 3

	weight = 0.02

/obj/item/cable/update_icon()
	var/icon_count = clamp(item_count_current,1,5)
	icon_state = "[initial(icon_state)]_[icon_count]"
	return ..()

/obj/item/cable/proc/treat(var/mob/caller,var/atom/A)

	if(heal_burn)
		A.health.adjust_burn_loss(-heal_burn)

	if(heal_burn_percent)
		A.health.adjust_burn_loss(-heal_burn_percent*A.health.get_burn_loss())

	if(heal_burn || heal_burn_percent)
		if(is_organ(A) && is_living(A.loc))
			var/mob/living/L = A.loc
			A.health.update_health()
			L.queue_health_update = TRUE
		else
			A.health.update_health()

	if(caller == A.loc)
		caller.visible_message("\The [caller.name] replaces the wires in their [A.name].")
	else
		caller.visible_message("\The [caller.name] replaces the wires in \the [A.loc.name]'s [A.name].")

	add_item_count(-1)

	return TRUE

/obj/item/cable/proc/can_be_treated(var/mob/caller,var/atom/target)

	INTERACT_CHECK
	INTERACT_CHECK_OTHER(target)

	if(!is_organ(target) && !is_living(target))
		caller.to_chat("You can't treat this!")
		return FALSE

	if(!target || !target.health)
		caller.to_chat("You can't treat this!")
		return FALSE

	return TRUE



/obj/item/cable/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_inventory(object))
		return ..()

	var/self_treat = caller == object

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/list/new_x_y = A.get_current_target_cords(params)
		params[PARAM_ICON_X] = new_x_y[1]
		params[PARAM_ICON_Y] = new_x_y[2]
		object = object.get_object_to_damage(caller,src,params,TRUE,TRUE)

	if(can_be_treated(caller,object))
		PROGRESS_BAR(caller,src,self_treat ? BASE_TREATMENT_TIME_SELF : BASE_TREATMENT_TIME,.proc/treat,caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_be_treated,caller,object)
		return TRUE

	return ..()