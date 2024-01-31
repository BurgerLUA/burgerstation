/obj/item/doctor_bag
	name = "doctor's bag"
	desc = "I need healing."
	desc_extended = "A highly advanced set of surgery tools and general medical equipment to make you excel at your duties of being a doctor. \
	Heals the target's limb by a fixed amount based on your medical skill. Treatment time is also based on your medical skill. Unlimited use; cannot be used to self-treat."
	icon = 'icons/obj/item/doctor_bag.dmi'
	icon_state = "inventory"

	value = 1200

	var/organic = TRUE

	var/heal_brute = 20 //At 100 medicine.
	var/heal_burn = 20 //At 100 medicine.

	var/heal_brute_percent = 5 //At 100 medicine.
	var/heal_burn_percent = 5 //At 100 medicine.

	var/base_delay = SECONDS_TO_DECISECONDS(1)
	var/added_delay = SECONDS_TO_DECISECONDS(9) //At 0 medicine. Gets reduced to 0 at 100 medicine.

	rarity = RARITY_RARE

	size = SIZE_3

	quality = 100

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
			PROGRESS_BAR(caller,src,SECONDS_TO_DECISECONDS(4),src::treat(),caller,object) //Takes 4 seconds to get started.
			PROGRESS_BAR_CONDITIONS(caller,src,src::can_be_treated(),caller,object)

		return TRUE

	. = ..()


/obj/item/doctor_bag/proc/can_be_treated(var/mob/caller,var/atom/target)

	INTERACT_CHECK_NO_DELAY(src)
	INTERACT_CHECK_NO_DELAY(target)

	if(!is_organ(target) && !is_living(target))
		caller.to_chat(span("warning","You can't treat \the [target.name]!"))
		return FALSE

	if(!target || !target.health)
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
	return TRUE



/obj/item/doctor_bag/proc/treat(var/mob/living/caller,var/atom/A)

	var/medicine_power = caller.get_skill_power(SKILL_MEDICINE,0,1,2) * (src.quality/100)

	var/mob/living/L
	if(is_organ(A) && is_living(A.loc))
		L = A.loc
	else
		L = A

	if(!L.horizontal)
		medicine_power *= 0.25

	if(is_organ(A))
		var/obj/item/organ/O = A
		O.bleeding = max(0,O.bleeding - medicine_power)

	var/total_healed = 0

	var/brute_to_heal = (-heal_brute*medicine_power) + (-heal_brute_percent*A.health.damage[BRUTE]*medicine_power)
	var/burn_to_heal = (-heal_burn*medicine_power) + (-heal_burn_percent*A.health.damage[BURN]*medicine_power)

	if(brute_to_heal || burn_to_heal)
		total_healed += A.health.adjust_loss_smart(brute = brute_to_heal, burn = burn_to_heal,robotic=!organic,organic=organic)

	if(total_healed > 0 && is_player(caller))
		var/mob/living/advanced/player/P = caller
		if(!enable_friendly_fire && P.loyalty_tag == L.loyalty_tag) //Prevents an exploit where you hit then heal the enemy.
			var/experience_gain = total_healed*5
			P.add_skill_xp(SKILL_MEDICINE,CEILING(experience_gain,1))

			if(P.job)
				var/job/J = JOB(P.job)
				if(J && J.job_flags & FLAG_JOB_HEALING)
					var/income_multiplier = J.active_income_multiplier + J.active_income_multiplier_bonus*P.job_rank
					var/currency_gain = min(P.insurance,CEILING(total_healed*income_multiplier,1))
					if(currency_gain > 0)
						P.insurance -= currency_gain
						P.to_chat(span("notice","Your insurance was charged [currency_gain] credits for the treatment by [caller.name]."))
					currency_gain += CEILING(total_healed*0.25*income_multiplier,1) //Bonus
					var/currency_given = P.adjust_currency(currency_gain,silent=TRUE)
					if(currency_given > 0)
						P.to_chat(span("notice","You were paid [currency_given] credits for treating [src.name]."))

	if(reagents && !reagents.contains_lethal)
		var/reagent_transfer = CEILING((1/amount_max)*reagents.volume_current, 1)
		reagents.transfer_reagents_to(A.reagents,reagent_transfer, caller = caller)
		reagents.volume_max = amount*10

	if(caller == A.loc)
		caller.visible_message(span("notice","\The [caller.name] treat their [A.name]."),span("notice","You treat your [A.name]."))
	else
		caller.visible_message(span("warning","\The [caller.name] treat \the [A.loc.name]'s [A.name]."),span("notice","You treat \the [A.loc.name]'s [A.name]."))

	PROGRESS_BAR(caller,src,base_delay + max(0,added_delay*(1-medicine_power)),src::treat(),caller,A)
	PROGRESS_BAR_CONDITIONS(caller,src,src::can_be_treated(),caller,A)

	use_condition(0.1) //About 1000 uses.

	return TRUE