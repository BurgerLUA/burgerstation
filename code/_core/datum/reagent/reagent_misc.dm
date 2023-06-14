/reagent/tinea_luxor
	name = "tinea luxor"
	desc = "A strange reagent that makes the consumer glow. One unit lasts 5 seconds."
	metabolism_stomach = 1/5
	metabolism_blood = 1/5

	flags_metabolism = REAGENT_METABOLISM_STOMACH | REAGENT_METABOLISM_BLOOD

/reagent/tinea_luxor/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0,var/mob/living/caller)
	var/obj/item/weapon/melee/torch/tinea_luxor/TL = locate() in L.contents
	if(!TL)
		TL = new(L)
		INITIALIZE(TL)
		GENERATE(TL)
		FINALIZE(TL)
	. = ..()

/reagent/tinea_luxor/on_remove_living(var/mob/living/L,var/reagent_container/container)
	var/obj/item/weapon/melee/torch/tinea_luxor/TL = locate() in L.contents
	if(TL) qdel(TL)
	. = ..()