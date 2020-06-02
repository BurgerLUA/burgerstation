/reagent/magic
	name = "magic medicine"

/reagent/magic/stand_juice
	name = "Stand Juice"
	desc = "Gives you a stand."
	color = "#B200FF"
	flavor = "cola"

	value = 10

	lethal = TRUE

	liquid = 0.6


/reagent/magic/stand_juice/on_add(var/reagent_container/container,var/amount_added=0,var/current_volume=0)

	. = ..()

	if(. + current_volume >= 10 && container.flags_metabolism & REAGENT_METABOLISM_INGEST)
		if(is_living(container.owner.loc))
			var/mob/living/L = container.owner.loc
			L.add_stand()
			if(current_volume) container.remove_reagent(src.type,current_volume,should_update = FALSE, check_recipes = FALSE)
			return 0

	return .