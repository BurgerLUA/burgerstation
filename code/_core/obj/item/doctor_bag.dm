/obj/item/doctor_bag
	name = "doctor's bag"
	desc = "HOLD STILL!"
	desc_extended = "A highly advanced set of surgery tools and general medical equipment to make you excel at your duties of being a doctor. \
	Heals the target's limb by a fixed amount based on your medical skill. Treatment power and time is also based on your medical skill, and is improved if the target is laying down. Cannot be used to self-treat. Using this while taking the Medical Doctor job can earn you credits if you treat your fellow man. Clicking on it will let you change healing modes."
	icon = 'icons/obj/item/doctor_bag.dmi'
	icon_state = "inventory"

	value = 1 //generated

	var/organic = TRUE
	var/heal_all_limbs = FALSE

	var/heal_brute = 20 //At 100 medicine.
	var/heal_burn = 20 //At 100 medicine.

	var/heal_brute_percent = 5 //At 100 medicine.
	var/heal_burn_percent = 5 //At 100 medicine.

	var/base_delay = SECONDS_TO_DECISECONDS(1)
	var/added_delay = SECONDS_TO_DECISECONDS(5) //At 0 medicine. Gets reduced to 0 at 100 medicine.

	rarity = RARITY_RARE

	size = SIZE_3

	quality_max = 190
	quality = 100

	uses_until_condition_fall = 1

/obj/item/doctor_bag/get_base_value()
	. = 100 + ((heal_burn+heal_brute)*10 + (heal_brute_percent + heal_burn_percent)*40) * (SECONDS_TO_DECISECONDS(6) / (base_delay + added_delay*0.5)) * 1.5
	. = FLOOR(.,100)

/obj/item/doctor_bag/click_self(var/mob/caller,location,control,params)

	INTERACT_CHECK
	INTERACT_DELAY(1)

	heal_all_limbs = !heal_all_limbs
	if(heal_all_limbs)
		caller.to_chat(span("notice","You decide to heal injuries of others more broadly, at the cost of healing power."))
	else
		caller.to_chat(span("warning","You decide to focus on healing a singular limb."))

	return TRUE

/obj/item/doctor_bag/click_on_object(var/mob/caller,var/atom/object,location,control,params)

	if(is_living(object) && is_living(caller))

		var/mob/living/L = caller
		var/mob/living/T = object

		if(L == T)
			caller.to_chat(span("warning","The surgical procedure is too complex to self-treat!"))
			return TRUE

		if(is_advanced(caller))
			var/mob/living/advanced/A = caller
			var/list/new_x_y = A.get_current_target_cords(params)
			params[PARAM_ICON_X] = new_x_y[1]
			params[PARAM_ICON_Y] = new_x_y[2]
			object = object.get_object_to_damage(caller,src,null,params,TRUE,TRUE)

		if(can_be_treated(caller,object))
			INTERACT_CHECK
			INTERACT_CHECK_OBJECT
			var/treatment_name = object.name
			if(is_living(object.loc))
				treatment_name = "[object.loc.name]'s [treatment_name]"
			caller.visible_message(span("notice","\The [caller.name] begins treating \the [treatment_name]..."),span("notice","You begin treating \the [treatment_name]."))
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(3),src::treat(),caller,object) //Takes 3 seconds to get started.
			PROGRESS_BAR_CONDITIONS(caller,src,src::can_be_treated(),caller,object)

		return TRUE

	. = ..()


/obj/item/doctor_bag/proc/can_be_treated(var/mob/living/caller,var/atom/target)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target)

	if(!target.health)
		caller.to_chat(span("warning","You can't treat \the [target.name]!"))
		return FALSE

	var/mob/living/actual_target
	if(is_living(target))
		actual_target = target
	else if(is_organ(target) && is_living(target.loc))
		actual_target = target.loc

	if(!actual_target || !allow_helpful_action(caller.loyalty_tag,actual_target))
		caller.to_chat(span("warning","You can't treat \the [target.name]!"))
		return FALSE

	if(organic)
		if(!target.health.organic)
			caller.to_chat(span("warning","\The [src.name] can only treat organic limbs!"))
			return FALSE
	else
		if(target.health.organic)
			caller.to_chat(span("warning","\The [src.name] can only treat non-organic limbs!"))
			return FALSE

	if(target.health.damage[BRUTE] <= 0 && target.health.damage[BURN] <= 0)
		if(is_organ(target))
			var/obj/item/organ/O = target
			if(O.bleeding <= 0)
				caller.to_chat(span("notice","\The [O.name] doesn't need any more treatment!"))
				return FALSE
		else
			caller.to_chat(span("notice","\The [target.name] doesn't need any more treatment!"))
			return FALSE

	return TRUE



/obj/item/doctor_bag/proc/treat(var/mob/living/caller,var/atom/A)

	var/medicine_power = caller.get_skill_power(SKILL_MEDICINE,0,1,2) * (src.quality/100)

	var/mob/living/target_as_living
	if(is_organ(A) && is_living(A.loc))
		target_as_living = A.loc
	else
		target_as_living = A

	if(target_as_living == caller) //Self-treatment penalty.
		medicine_power *= 0.5

	if(!target_as_living.horizontal) //Not horizontal penalty.
		medicine_power *= 0.5

	if(heal_all_limbs && is_living(A.loc)) // If we are on the second healing mode, heal more broadly at a severe penalty.
		A = A.loc
		medicine_power *= 0.25

	medicine_power = max(medicine_power,0.1)

	if(is_organ(A))
		var/obj/item/organ/O = A
		O.bleeding = max(0,O.bleeding - medicine_power) //Reduce bleeding.

	var/brute_to_heal = (-heal_brute*medicine_power) + (-heal_brute_percent*A.health.damage[BRUTE]*medicine_power)
	var/burn_to_heal = (-heal_burn*medicine_power) + (-heal_burn_percent*A.health.damage[BURN]*medicine_power)

	var/total_healed = 0
	if(brute_to_heal || burn_to_heal)
		total_healed += A.health.adjust_loss_smart(brute = brute_to_heal, burn = burn_to_heal,robotic=!organic,organic=organic)

	if(total_healed > 0 && is_player(caller) && !allow_hostile_action(caller.loyalty_tag,target_as_living))
		var/mob/living/advanced/player/P = caller
		var/experience_gain = total_healed*5
		P.add_skill_xp(SKILL_MEDICINE,CEILING(experience_gain,1))
		if(P.job && is_player(target_as_living))
			var/mob/living/advanced/player/target_as_player = target_as_living
			var/job/J = JOB(P.job)
			if(J && J.job_flags & FLAG_JOB_HEALING)
				var/income_multiplier = J.active_income_multiplier + J.active_income_multiplier_bonus*P.job_rank
				var/currency_gain = min(target_as_player.insurance,CEILING(total_healed*income_multiplier,1))
				if(currency_gain > 0)
					target_as_player.insurance -= currency_gain
					target_as_player.to_chat(span("notice","Your insurance was charged [currency_gain] credits for the treatment by [P.name]."))
				currency_gain += CEILING(total_healed*0.25*income_multiplier,1) //Bonus
				var/currency_given = P.adjust_currency(currency_gain,silent=TRUE)
				if(currency_given > 0)
					P.to_chat(span("notice","You were paid [currency_given] credits for treating [target_as_player.name]."))

	if(reagents && !reagents.contains_lethal)
		var/reagent_transfer = min(10,reagents.volume_current)
		reagents.transfer_reagents_to(A.reagents,reagent_transfer, caller = caller)

	if(caller == target_as_living) //Self treatment.
		caller.visible_message(span("notice","\The [caller.name] treats their [A.name]."),span("notice","You treat your [A.name]."))
	else
		caller.visible_message(span("warning","\The [caller.name] treats \the [A.loc.name]'s [A.name]."),span("notice","You treat \the [A.loc.name]'s [A.name]."))

	PROGRESS_BAR(caller,src,base_delay + max(0,added_delay*(1-medicine_power)),src::treat(),caller,A)
	PROGRESS_BAR_CONDITIONS(caller,src,src::can_be_treated(),caller,A)

	use_condition(1)

	return TRUE
