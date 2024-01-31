/addiction/health
	name = "Health Product Addiction"
	reagent_name = "Health Products"


/addiction/health/on_life(mob/living/advanced/A,obj/item/organ/internal/brain/B,addiction_value=0,withdrawal_value=0)

	if(withdrawal_value >= 5 && prob(withdrawal_value))

		if(prob(25))
			A.to_chat(span("danger","You crave health and diet products..."))
		switch(rand(1,3))
			if(1)
				A.brute_regen_buffer -= TICKS2DS(LIFE_TICK_SLOW)
				A.to_chat(span("warning","Your body itches..."))
			if(2)
				A.sanity_regen_buffer -= -TICKS2DS(LIFE_TICK_SLOW)
				A.to_chat(span("warning","You feel moody..."))
			if(3)
				A.mental_regen_buffer -= TICKS2DS(LIFE_TICK_SLOW)
				A.to_chat(span("warning","You can't seem to think..."))

	return ..()
