/obj/item/organ/internal/heart
	name = "heart"
	id = BODY_HEART
	icon_state = BODY_HEART
	desc = "Pumps blood throughout the body."

	attach_flag = BODY_TORSO

	reagents = /reagent_container/heart

	var/heart_rate = 60 //Resting, Measured in beats per minute

	var/heart_ticks = 0

	has_life = FALSE



/obj/item/organ/internal/heart/robotic
	name = "robotic heart"



/*
/obj/item/organ/internal/heart/on_life()

	. = ..()

	if(is_advanced(src.loc))

		var/mob/living/advanced/A = src.loc

		if(A.dead)
			heart_rate = 0
			return .

		var/health_percent = A.health.health_current / A.health.health_max
		var/stamina_percent = A.health.stamina_current / A.health.stamina_max
		var/blood_percent = A.reagents.get_reagent_volume("blood") / BLOOD_LEVEL_DEFAULT
		var/is_crit = A.has_status_effect(CRIT)

		heart_ticks += LIFE_TICK
		heart_rate = initial(heart_rate)
		heart_rate *= (blood_percent)
		if(is_crit)
			heart_rate *= 0.5

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
			if( !is_crit && health_percent >= 0.5 && blood_percent < 1)
				A.reagents.add_reagent(/reagent/blood,0.1)
			var/desired_oxyloss = FLOOR(A.health.health_max * 2 * (1-blood_percent),1)
			var/current_oxyloss = FLOOR(A.health.get_oxy_loss(),1)
			if(is_crit || desired_oxyloss > current_oxyloss)
				A.health.adjust_loss_smart(oxy=1)
			else if (desired_oxyloss < current_oxyloss)
				A.health.adjust_loss_smart(oxy=-1)
			heart_ticks = 0

	return .
*/