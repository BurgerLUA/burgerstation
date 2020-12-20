/addiction/
	var/name = "Addiction Name"
	var/reagent_name = "Reagent Name"
	var/list/addiction_reagents = list()

/addiction/proc/on_add(var/mob/living/advanced/A,var/obj/item/organ/internal/brain/B,var/addiction_value=0,var/withdrawal_value=0)
	return TRUE

/addiction/proc/on_add_initial(var/mob/living/advanced/A,var/obj/item/organ/internal/brain/B,var/addiction_value=0,var/withdrawal_value=0)
	A.to_chat(span("danger","You've become addicted to [reagent_name]."))
	return TRUE

/addiction/proc/on_life(var/mob/living/advanced/A,var/obj/item/organ/internal/brain/B,var/addiction_value=0,var/withdrawal_value=0)

	if(B.addictions[src.type] <= 0)
		on_remove(A,B)
		B.addictions -= src.type
		B.withdrawal -= src.type
		return FALSE

	B.addictions[src.type] -= CEILING(DECISECONDS_TO_SECONDS(LIFE_TICK_SLOW)*(1/60)*(1/60)*15,0.001) //Takes an hour to remove addiction from a 15u dose, naturally.
	B.withdrawal[src.type] += CEILING(DECISECONDS_TO_SECONDS(LIFE_TICK_SLOW)*(1/60)*(1/30)*addiction_value,0.001) //Must take a max dose every 30 mins if addicted.

	return TRUE

/addiction/proc/on_remove(var/mob/living/advanced/A,var/obj/item/organ/internal/brain/B)
	A.to_chat(span("notice","You are no longer addicted to [reagent_name]."))
	return TRUE