/reagent/magic
	name = "magic medicine"

/reagent/magic/stand_juice
	name = "Stand Juice"
	id = "stand"
	desc = "Gives you a stand."
	color = "#B200FF"
	flavor = "cola"

	value = 10

	lethal = TRUE

	liquid = 0.6


/reagent/magic/stand_juice/on_add(var/reagent_container/container,var/amount_added=0)

	. = ..()

	if(. >= 10 && container.flags_metabolism & REAGENT_METABOLISM_INGEST)
		var/mob/living/L = container.owner.loc
		if(istype(L))
			L.add_stand()
		container.remove_reagent(id,.)

	return .