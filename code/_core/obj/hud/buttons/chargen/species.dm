/obj/hud/button/chargen/species/
	name = "change species"
	icon_state = "change_species"
	screen_loc = "CENTER+2,CENTER+0"

	user_colors = TRUE

	chargen_flags = CHARGEN_NONE

/obj/hud/button/chargen/species/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_advanced(caller))
		var/mob/living/advanced/A = caller

		var/species_choice = input("What species do you wish to change to?") as null|anything in list("Human","Lizard","Cyborg")
		if(!species_choice)
			return TRUE

		var/list/choice_to_species = list(
			"Human" = "human",
			"Lizard" = "reptile_advanced",
			"Cyborg" = "cyborg"
		)

		var/choice = input("Are you sure you want to change your species to [species_choice]? Your appearance will reset to that species' default.","Species Change") in list("Yes","No")

		if(choice == "Yes")
			A.perform_specieschange(choice_to_species[species_choice],TRUE,TRUE)

	return .

