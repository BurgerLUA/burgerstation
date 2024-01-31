/addiction/painkillers
	name = "Painkillers Addiction"
	reagent_name = "Painkillers"


/addiction/painkillers/on_life(var/mob/living/advanced/A,var/obj/item/organ/internal/brain/B,var/addiction_value=0,var/withdrawal_value=0)

	if(withdrawal_value >= 15 && prob(withdrawal_value))

		if(prob(25))
			A.to_chat(span("danger","You crave [lowertext(reagent_name)]..."))
		switch(rand(1,3))
			if(1)
				A.brute_regen_buffer -= TICKS_TO_DECISECONDS(LIFE_TICK_SLOW)
				A.to_chat(span("warning","Your body itches..."))
			if(2)
				A.tox_regen_buffer -= TICKS_TO_DECISECONDS(LIFE_TICK_SLOW)
				A.to_chat(span("warning","You feel sick..."))
			if(3)
				A.burn_regen_buffer -= TICKS_TO_DECISECONDS(LIFE_TICK_SLOW)
				A.to_chat(span("warning","Your skin breaks out in blisters..."))

	return ..()