//Medicine like band-aids and the such.

/obj/item/container/medicine
	name = "medicine"
	desc = "For when you have a boo-boo."
	desc_extended = "Apply to your wounds or damaged limbs to treat."
	icon = 'icons/obj/item/medicine.dmi'

	var/heal_brute = 0
	var/heal_brute_percent = 0
	var/heal_burn = 0
	var/heal_burn_percent = 0
	var/heal_bleeding = FALSE

	var/verb_to_use = "treat"

	var/treatment_time = 5

	item_count_current = 5
	item_count_max = 10

	var/icon_state_max = 3

	reagents = /reagent_container/medicine

	var/override_icon_state = FALSE

	var/robotic = FALSE //Set to true if heals robotic limbs and not organic limbs.

/obj/item/container/medicine/Initialize(var/desired_loc)

	. = ..()

	if(reagents)
		reagents.volume_max = item_count_current*10

	return .

/obj/item/container/medicine/update_icon()

	if(!override_icon_state)
		icon = initial(icon)
		icon_state = "[initial(icon_state)]_[clamp(item_count_current,1,icon_state_max)]"

	return ..()

/obj/item/container/medicine/proc/treat(var/mob/caller,var/atom/A)

	if(!reagents)
		CRASH_SAFE("[src.get_debug_name()] had no reagents!")
		return FALSE

	if(heal_bleeding && is_organ(A))
		var/obj/item/organ/O = A
		O.bleeding = 0

	. = FALSE

	if(heal_brute)
		A.health.adjust_brute_loss(-heal_brute)
		. = TRUE

	if(heal_brute_percent)
		A.health.adjust_brute_loss(-heal_brute_percent*A.health.get_brute_loss())
		. = TRUE

	if(heal_burn)
		A.health.adjust_burn_loss(-heal_burn)
		. = TRUE

	if(heal_burn_percent)
		A.health.adjust_burn_loss(-heal_burn_percent*A.health.get_burn_loss())
		. = TRUE

	if(.)
		if(is_organ(A) && is_living(A.loc))
			var/mob/living/L = A.loc
			A.health.update_health()
			L.queue_health_update = TRUE
		else
			A.health.update_health()

	var/reagent_transfer = CEILING((1/item_count_max)*reagents.volume_current, 1)
	reagents.transfer_reagents_to(A.reagents,reagent_transfer)
	reagents.volume_max = item_count_current*10

	if(caller == A.loc)
		caller.visible_message("\The [caller.name] bandages their [A.name].")
	else
		caller.visible_message("\The [caller.name] bandages \the [A.loc.name]'s [A.name].")

	add_item_count(-1)


	return TRUE

/obj/item/container/medicine/proc/can_be_treated(var/mob/caller,var/atom/target)

	if(!is_organ(target) && !is_living(target))
		caller.to_chat("You can't treat this!")
		return FALSE

	if(!target || !target.health)
		caller.to_chat("You can't treat this!")
		return FALSE

	if(get_dist(caller,target) > 1)
		caller.to_chat("You're too far away!")
		return FALSE

	return TRUE



/obj/item/container/medicine/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(is_inventory(object))
		return ..()

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/list/new_x_y = A.get_current_target_cords(params)
		params[PARAM_ICON_X] = new_x_y[1]
		params[PARAM_ICON_Y] = new_x_y[2]
		object = object.get_object_to_damage(caller,src,params,TRUE,TRUE)

	if(can_be_treated(caller,object))
		PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(1),.proc/treat,caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_be_treated,caller,object)
		return TRUE

	return ..()