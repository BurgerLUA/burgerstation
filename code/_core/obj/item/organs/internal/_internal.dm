/obj/item/organ/internal
	name = "internal organ"
	desc = "An internal organ, it is now outside."
	has_dropped_icon = TRUE

	enable_skin = FALSE
	enable_glow = FALSE
	enable_detail = FALSE
	enable_wounds = FALSE

	reagents = null

/obj/item/organ/internal/brain
	name = "brain"
	id = BODY_BRAIN
	icon_state = BODY_BRAIN
	desc = "Produces thoughts. Requires oxygenated blood."

	attach_flag = BODY_HEAD

/obj/item/organ/internal/brain/unattach_from_parent(var/turf/T)
	if(is_advanced(src.loc))
		var/mob/living/advanced/A = src.loc
		A.death()

	..()

/obj/item/organ/internal/lungs
	name = "lungs"
	id = BODY_LUNGS
	desc = "Produces oxygenated blood. Requires blood, oxygen."
	icon_state = "lungs"

	attach_flag = BODY_TORSO

/obj/item/organ/internal/stomach
	name = "stomach"
	id = BODY_STOMACH
	icon_state = BODY_STOMACH
	desc = "Produces digested nutrients and digested liquid. Requires food, water, and oxygenated blood."

	attach_flag = BODY_TORSO

	reagents = /reagent_container/stomach

/obj/item/organ/internal/liver
	name = "liver"
	id = BODY_LIVER
	icon_state = BODY_LIVER
	desc = "Produces bile. Requires vitamins and oxygenated blood."

	attach_flag = BODY_TORSO

/obj/item/organ/internal/intestines
	name = "intestines"
	id = BODY_INTESTINTES
	icon_state = BODY_INTESTINTES
	desc = "Produces vitamins and waste. Requires digested nutrients, digested liquid, and oxygenated blood."

	attach_flag = BODY_GROIN

/obj/item/organ/internal/kidneys
	name = "kidneys"
	id = BODY_KIDNEYS
	icon_state = BODY_KIDNEYS
	desc = "Filters waste from blood. Requires things."

	attach_flag = BODY_GROIN

/obj/item/organ/internal/heart
	name = "heart"
	id = BODY_HEART
	icon_state = BODY_HEART
	desc = "Pumps blood throughout the body."

	attach_flag = BODY_TORSO

	reagents = /reagent_container/heart

	var/heart_rate = 60 //Resting, Measured in beats per minute

	var/heart_ticks = 0

/obj/item/organ/internal/heart/on_life()

	. = ..()

	if(is_advanced(src.loc))

		var/mob/living/advanced/A = src.loc

		if(A.dead)
			heart_rate = 0
			return .

		var/health_percent = A.health.health_current / A.health.health_max
		var/stamina_percent = A.health.stamina_current / A.health.stamina_max
		var/blood_percent = A.reagents.get_reagent_count("blood") / BLOOD_LEVEL_DEFAULT

		heart_ticks += LIFE_TICK

		heart_rate = initial(heart_rate)
		heart_rate *= (blood_percent)
		if(health_percent > 0.5)
			heart_rate *= (2 - health_percent)
		else
			heart_rate *= health_percent
		switch(stamina_percent)
			if(0 to 0.25)
				heart_rate *= 3
			if(0.25 to 0.5)
				heart_rate *= 2.5
			if(0.5 to 0.99)
				heart_rate *= 2

		if(heart_rate && heart_ticks >= ((1/heart_rate)*60)*10)
			if(health_percent >= 0.5 && blood_percent < 1)
				A.reagents.add_reagent("blood",0.1)
			var/desired_oxyloss = FLOOR(A.health.health_max * 2 * (1-blood_percent),1)
			var/current_oxyloss = FLOOR(A.health.get_oxy_loss(),1)
			if(desired_oxyloss > current_oxyloss)
				A.health.adjust_loss_smart(oxy=1)
			else if (desired_oxyloss < current_oxyloss)
				A.health.adjust_loss_smart(oxy=-1)
			heart_ticks = 0

	return .




