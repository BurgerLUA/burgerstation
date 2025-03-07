//Medicine like band-aids and the such.

/obj/item/container/healing
	name = "medicine"
	desc = "For when you have a boo-boo."
	desc_extended = "Apply to your wounds or damaged limbs to treat."
	icon = 'icons/obj/item/medicine.dmi'

	var/heal_brute = 0
	var/heal_brute_percent = 0
	var/heal_burn = 0
	var/heal_burn_percent = 0
	var/heal_bleeding = FALSE
	var/reagent_max_per_amount = 15

	var/verb_to_use = "treat"

	var/treatment_time_mul = 1

	var/treatment_sound

	amount = 1
	amount_max = 10

	var/icon_state_max = 3

	reagents = /reagent_container/medicine

	var/override_icon_state = FALSE

	var/organic = TRUE //Set to false if heals robotic limbs and not organic limbs.

	size = SIZE_1

/obj/item/container/healing/get_base_value()
	. = abs(heal_brute+heal_burn)*0.2 + abs(heal_brute_percent+heal_burn_percent)*0.3 + (heal_bleeding ? 20 : 0)
	. = CEILING(.,1)

/obj/item/container/healing/Generate(var/desired_loc)
	. = ..()
	if(reagents) reagents.volume_max = amount * reagent_max_per_amount

/obj/item/container/healing/Finalize(var/desired_loc)
	. = ..()
	if(reagents) reagents.volume_max = amount * reagent_max_per_amount //Safety

/obj/item/container/healing/add_item_count(var/amount_to_add, var/bypass_checks = FALSE)
	. = ..()
	if(reagents && amount) reagents.volume_max = amount * reagent_max_per_amount

/obj/item/container/healing/quick(var/mob/activator,var/atom/object,location,params)

	if(!is_advanced(activator) || !is_inventory(src.loc))
		return FALSE

	var/mob/living/advanced/A = activator

	return A.put_in_hands(src,params)

/obj/item/container/healing/Finalize()
	. = ..()
	update_sprite()

/obj/item/container/healing/update_icon()

	if(!override_icon_state)
		icon = initial(icon)
		icon_state = "[initial(icon_state)]_[clamp(amount,1,icon_state_max)]"

	return ..()

/obj/item/container/healing/proc/treat(var/mob/activator,var/atom/A)

	if(heal_bleeding && is_organ(A))
		var/obj/item/organ/O = A
		O.bleeding = 0

	var/heal_multiplier = 1

	if(is_living(activator))
		var/mob/living/L = activator
		heal_multiplier += L.get_skill_power(SKILL_MEDICINE,0,1,2)

	var/total_healed = 0

	var/brute_to_heal = (heal_brute*heal_multiplier) + (heal_brute_percent*A.health.damage[BRUTE]*heal_multiplier)
	var/burn_to_heal = (heal_burn*heal_multiplier) + (heal_burn_percent*A.health.damage[BURN]*heal_multiplier)

	if(brute_to_heal || burn_to_heal)
		total_healed -= A.health.adjust_loss_smart(brute = -brute_to_heal, burn = -burn_to_heal, robotic=!organic, organic=organic)

	if(total_healed > 0 && is_organ(A) && is_living(A.loc))
		var/mob/living/L = A.loc
		if(is_player(activator) && activator.client)
			var/mob/living/advanced/player/P = activator
			if(!enable_friendly_fire && P.loyalty_tag == L.loyalty_tag) //Prevents an exploit where you hit then heal the enemy.
				var/experience_gain = total_healed*5
				P.add_skill_xp(SKILL_MEDICINE,CEILING(experience_gain,1))

	if(reagents)
		var/transfer_amount = min(reagent_max_per_amount, reagents.volume_current)
		reagents.transfer_reagents_to(A.reagents, transfer_amount, activator = activator)

	if(activator == A.loc)
		activator.visible_message(span("notice","\The [activator.name] bandages their [A.name]."),span("notice","You bandage your [A.name]."))
	else
		activator.visible_message(span("warning","\The [activator.name] bandages \the [A.loc.name]'s [A.name]."),span("notice","You bandage \the [A.loc.name]'s [A.name]."))

	if(treatment_sound)
		play_sound(treatment_sound,get_turf(src))

	add_item_count(-1)

	return TRUE

/obj/item/container/healing/proc/can_be_treated(var/mob/activator,var/atom/target)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target)

	if(!is_organ(target) && !is_living(target))
		activator.to_chat(span("warning","You can't treat \the [target.name]!"))
		return FALSE

	if(!target || !target.health)
		activator.to_chat(span("warning","You can't treat \the [target.name]!"))
		return FALSE

	if(heal_brute < 0 || heal_burn < 0 || reagents.contains_lethal) //Hostile!
		if(!is_living(activator))
			return FALSE
		var/mob/living/activator_as_living = activator
		var/mob/living/target_as_living
		if(is_organ(target))
			var/obj/item/organ/O = target
			if(!is_living(O.loc))
				return FALSE
			target_as_living = O.loc
		else if(is_living(target))
			target_as_living = target
		else
			return FALSE
		if(activator_as_living != target_as_living)
			if(!allow_hostile_action(activator_as_living.loyalty_tag,target_as_living))
				activator.to_chat(span("warning","You'd feel it would be unsafe to treat your fellow man with the dangerous [src.name]..."))
				return FALSE

	if(organic)
		if(!target.health.organic)
			activator.to_chat(span("warning","\The [src.name] can only treat organic limbs!"))
			return FALSE
	else
		if(target.health.organic)
			activator.to_chat(span("warning","\The [src.name] can only treat non-organic limbs!"))
			return FALSE
	return TRUE



/obj/item/container/healing/click_on_object(var/mob/activator as mob,var/atom/object,location,control,params)

	if(object.plane >= PLANE_HUD)
		return ..()

	var/self_treat = activator == object

	if(is_advanced(activator))
		var/mob/living/advanced/A = activator
		var/list/new_x_y = A.get_current_target_cords(params)
		params[PARAM_ICON_X] = new_x_y[1]
		params[PARAM_ICON_Y] = new_x_y[2]
		object = object.get_object_to_damage(activator,src,null,params,TRUE,TRUE)

	if(can_be_treated(activator,object))
		INTERACT_CHECK
		INTERACT_CHECK_OBJECT
		PROGRESS_BAR(activator,src,(self_treat ? BASE_TREATMENT_TIME_SELF : BASE_TREATMENT_TIME) * treatment_time_mul,src::treat(),activator,object)
		PROGRESS_BAR_CONDITIONS(activator,src,src::can_be_treated(),activator,object)
		return TRUE

	return ..()
