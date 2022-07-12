/health/obj/item/organ/
	organic = TRUE

/health/obj/item/organ/restore()
	damage = list(BRUTE = 0, BURN = 0, TOX = 0, OXY = 0, FATIGUE = 0, PAIN=0, RAD=0, SANITY=0, MENTAL=0)
	if(is_advanced(owner.loc))
		var/mob/living/advanced/A = owner.loc
		A.queue_organ_health_update |= owner

/health/obj/item/organ/update_health_stats()

	if(!is_organ(owner))
		return ..()

	if(!is_advanced(owner.loc))
		return ..()

	var/obj/item/organ/O = owner
	var/mob/living/advanced/A = owner.loc

	. = ..()

	health_max = O.health_base * max(1,A.health.health_max/100)
	health_max = CEILING(health_max,5)

/health/obj/item/organ/update_health(var/atom/attacker,var/damage_dealt=0,var/update_hud=TRUE,var/check_death=TRUE)

	. = ..()

	if(.)

		if(!health_max)	return .

		if(!is_organ(owner)) return .

		var/obj/item/organ/O = owner

		if(!O.finalized) return .

		if(O.enable_wounds && is_advanced(O.loc))
			var/mob/living/advanced/A = O.loc
			var/should_update_overlay = FALSE
			for(var/damage_type in O.visual_wounds)
				var/last_amount = O.visual_wounds[damage_type]
				var/current_amount = clamp(CEILING((damage[damage_type]/health_max*0.5)*3, 1),0,3)
				if(last_amount != current_amount)
					var/desired_icon_state = current_amount ? "[O.id]_[damage_type]_[current_amount]" : "none"
					O.add_blend("damage_[damage_type]", desired_icon_state = desired_icon_state)
					O.visual_wounds[damage_type] = current_amount
					should_update_overlay = TRUE
					if(damage_type == BRUTE && current_amount == 0)
						O.bleeding = 0
			if(should_update_overlay)
				A.update_overlay_tracked("\ref[O]")

/health/obj/item/organ/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/fatigue,var/pain,var/rad,var/sanity,var/mental,var/organic=TRUE,var/robotic=TRUE,var/update=TRUE)

	if(src.organic && !organic)
		return 0

	if(!src.organic && !robotic) // I know these are technically called twice but it's to prevent the below snowflake code from running.
		return 0

	. = 0

	if(pain > 0 && is_advanced(owner.loc))
		var/obj/item/organ/O = owner
		var/mob/living/advanced/A = owner.loc
		A.mood -= pain*0.05
		O.send_pain_response(pain)

	if(tox || oxy || fatigue || sanity || mental) //These types should be dealt to the owner.
		if(is_advanced(owner.loc))
			var/mob/living/advanced/A = owner.loc
			if(A.health)
				. += A.health.adjust_loss_smart(
					tox=tox,
					oxy=oxy,
					fatigue=fatigue,
					sanity=sanity,
					mental=mental,
					update=update,
					organic=organic,
					robotic=robotic
				)

		tox = 0
		oxy = 0
		fatigue = 0
		sanity = 0
		mental = 0

	. += ..()

	if((brute || burn || rad || pain) && is_advanced(owner.loc))
		var/mob/living/advanced/A = owner.loc
		A.queue_organ_health_update |= owner

/health/obj/item/organ/synthetic
	resistance = list(PAIN=0,TOX=0)
	organic = FALSE

/health/obj/item/organ/synthetic/act_emp(var/atom/owner,var/atom/source,var/atom/epicenter,var/magnitude,var/desired_loyalty_tag)
	adjust_loss_smart(burn=magnitude,organic=FALSE,robotic=TRUE)
	return TRUE

/health/obj/item/organ/dummy
	organic = FALSE

/health/obj/item/organ/dummy/adjust_loss_smart(var/brute,var/burn,var/tox,var/oxy,var/fatigue,var/pain,var/rad,var/sanity,var/mental,var/organic=TRUE,var/robotic=TRUE,var/update=TRUE)
	return brute + burn + tox + oxy + fatigue + pain + rad + sanity + mental // + L + plundered + no wenches + marooned + you have scurvy