/obj/hud/button/chargen/species/
	icon_state = "square_round"
	screen_loc = "CENTER+2,CENTER+0"

/obj/hud/button/chargen/species/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller

		var/species_choice = input("What species do you wish to change to?") in list("Human","Lizard")

		var/list/choice_to_species = list(
			"Human" = "human",
			"Lizard" = "reptile_advanced"
		)

		var/choice = input("Are you sure you want to change your species to [species_choice]? Your appearance will reset to that species' default.","Species Change") in list("Yes","No")

		if(choice == "Yes")
			A.perform_specieschange(choice_to_species[species_choice],!A.underwear_added,TRUE)

	return TRUE

