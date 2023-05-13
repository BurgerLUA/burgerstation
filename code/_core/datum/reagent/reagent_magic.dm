/reagent/magic
	name = "magic medicine"
/*
/reagent/magic/stand_juice
	name = "Stand Juice"
	desc = "Gives you a stand."
	color = "#B200FF"
	alpha = 200

	flavor = "cola"

	value = 10

	lethal = TRUE

	liquid = 0.6


/reagent/magic/stand_juice/on_add_living(var/mob/living/L,var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(. + current_volume >= 10 && container.flags_metabolism & REAGENT_METABOLISM_INGEST)
		L.add_stand()
		if(current_volume) container.remove_reagent(src.type,current_volume,should_update = FALSE, check_recipes = FALSE)
		return 0
*/

/reagent/magic/armotol
	name = "Armo-tol"
	desc = "An odd chemical that makes you tougher."
	color = "#2600ff"
	alpha = 200

	metabolism_blood = 3/5
	metabolism_skin = 1/5
	metabolism_stomach = 2/5

	flavor = "steel"

	value = 10

	lethal = FALSE

	liquid = 0.6

/reagent/magic/armotol/on_metabolize_blood(mob/living/owner, reagent_container/container, amount_to_metabolize, starting_volume, multiplier)
	. = ..()
	if(owner.status_effects[TEMP_ARMOR])
		var/status_effect/E = owner.status_effects[TEMP_ARMOR]
		E.modify_duration(SECONDS_TO_DECISECONDS(60))
		E.modify_magnitude(. * 3)
	else
		owner.add_status_effect(TEMP_ARMOR,. * 2,SECONDS_TO_DECISECONDS(60))

/reagent/magic/armotol/on_metabolize_skin(mob/living/owner, reagent_container/container, amount_to_metabolize, starting_volume, multiplier)
	. = ..()
	if(owner.status_effects[TEMP_ARMOR])
		var/status_effect/E = owner.status_effects[TEMP_ARMOR]
		E.modify_duration(SECONDS_TO_DECISECONDS(60))
		E.modify_magnitude(. * 1)
	else
		owner.add_status_effect(TEMP_ARMOR,. * 2,SECONDS_TO_DECISECONDS(60))

/reagent/magic/armotol/on_metabolize_stomach(mob/living/owner, reagent_container/container, amount_to_metabolize, starting_volume, multiplier)
	. = ..()
	if(owner.status_effects[TEMP_ARMOR])
		var/status_effect/E = owner.status_effects[TEMP_ARMOR]
		E.modify_duration(src,owner,SECONDS_TO_DECISECONDS(60))
		E.modify_magnitude(src,owner,. * 2)
	else
		owner.add_status_effect(TEMP_ARMOR,. * 2,SECONDS_TO_DECISECONDS(60))

/reagent/magic/armotol/on_remove_living(var/mob/living/L, var/reagent_container/container)
	if(L.status_effects[TEMP_ARMOR])
		L.remove_status_effect(TEMP_ARMOR)
	. = ..()





