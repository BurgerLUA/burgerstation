/addiction/nicotine
	name = "Nicotine Addiction"
	reagent_name = "Nicotine"


/addiction/nicotine/on_life(var/mob/living/advanced/A,var/obj/item/organ/internal/brain/B,var/addiction_value=0,var/withdrawal_value=0)

	if(withdrawal_value >= 5 && prob(withdrawal_value))

		if(prob(25))
			A.to_chat(span("danger","You crave nicotine..."))
		switch(rand(1,3))
			if(1)
				A.brute_regen_buffer -= LIFE_TICK_SLOW
				A.to_chat(span("warning","Your body itches..."))
			if(2)
				A.to_chat(span("warning","You feel moody..."))
				A.health?.adjust_loss_smart(sanity=-LIFE_TICK_SLOW)
			if(2)
				A.to_chat(span("warning","You can't seem to think..."))
				A.health?.adjust_loss_smart(mental=-LIFE_TICK_SLOW)

	return ..()