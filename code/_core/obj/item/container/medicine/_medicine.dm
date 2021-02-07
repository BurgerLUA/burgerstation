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

	var/treatment_time_mul = 1

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

	var/heal_multiplier = 1

	if(is_living(caller))
		var/mob/living/L = caller
		heal_multiplier += L.get_skill_power(SKILL_MEDICINE)

	. = 0

	var/brute_to_heal = (-heal_brute*heal_multiplier) + (-heal_brute_percent*A.health.get_loss(BRUTE)*heal_multiplier)
	var/burn_to_heal = (-heal_burn*heal_multiplier) + (-heal_burn_percent*A.health.get_loss(BURN)*heal_multiplier)

	if(brute_to_heal || burn_to_heal)
		. += A.health.adjust_loss_smart(brute = brute_to_heal, burn = burn_to_heal)

	if(.)
		if(is_organ(A) && is_living(A.loc))
			var/mob/living/L = A.loc
			A.health.update_health()
			L.queue_health_update = TRUE
			if(is_player(caller))
				var/mob/living/advanced/player/P = caller
				if(L.loyalty_tag == P.loyalty_tag) //Prevents an exploit.
					var/experience_gain = -.*5
					P.add_skill_xp(SKILL_MEDICINE,CEILING(experience_gain,1))
		else
			A.health.update_health()

	var/reagent_transfer = CEILING((1/item_count_max)*reagents.volume_current, 1)
	reagents.transfer_reagents_to(A.reagents,reagent_transfer, caller = caller)
	reagents.volume_max = item_count_current*10

	if(caller == A.loc)
		caller.visible_message(span("notice","\The [caller.name] bandages their [A.name]."),span("notice","You bandage your [A.name]."))
	else
		caller.visible_message(span("warning","\The [caller.name] bandages \the [A.loc.name]'s [A.name]."),span("notice","You bandage \the [A.loc.name]'s [A.name]."))

	add_item_count(-1)

	return TRUE

/obj/item/container/medicine/proc/can_be_treated(var/mob/caller,var/atom/target)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target)

	if(!is_organ(target) && !is_living(target))
		caller.to_chat(span("warning","You can't treat \the [target.name]!"))
		return FALSE

	if(!target || !target.health)
		caller.to_chat(span("warning","You can't treat \the [target.name]!"))
		return FALSE

	if(robotic)
		if(target.health.organic)
			caller.to_chat(span("warning","\The [src.name] can only treat robotic limbs!"))
			return FALSE
	else
		if(!target.health.organic)
			caller.to_chat(span("warning","\The [src.name] can only treat organic limbs!"))
			return FALSE
	return TRUE



/obj/item/container/medicine/click_on_object(var/mob/caller as mob,var/atom/object,location,control,params)

	if(object.plane >= PLANE_HUD)
		return ..()

	var/self_treat = caller == object

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/list/new_x_y = A.get_current_target_cords(params)
		params[PARAM_ICON_X] = new_x_y[1]
		params[PARAM_ICON_Y] = new_x_y[2]
		object = object.get_object_to_damage(caller,src,params,TRUE,TRUE)

	if(can_be_treated(caller,object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		PROGRESS_BAR(caller,src,(self_treat ? BASE_TREATMENT_TIME_SELF : BASE_TREATMENT_TIME) * treatment_time_mul,.proc/treat,caller,object)
		PROGRESS_BAR_CONDITIONS(caller,src,.proc/can_be_treated,caller,object)
		return TRUE

	return ..()