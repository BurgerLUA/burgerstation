#define INTERACT_CHECK if(!can_interact(caller)) return FALSE



obj/structure/interactive/chargen_mirror
	name = "magic mirror"
	desc = "A magic mirror. This probably does something."
	density = 0
	icon = 'icons/obj/structure/medieval/bathroom.dmi'
	icon_state = "mirror"

	var/change_name = TRUE
	var/change_species = TRUE
	var/change_sex = TRUE
	var/change_skin = TRUE
	var/change_eye = TRUE
	var/change_hair = TRUE

obj/structure/interactive/chargen_mirror/clicked_by_object(caller,object,location,control,params)

	if(!is_advanced(caller))
		return FALSE

	var/mob/living/advanced/A = caller

	while(TRUE)
		INTERACT_CHECK

		var/datum/species/S = A.mob_species
		var/chargen_options = S.flags_chargen

		var/valid_options = list()
		valid_options += "Name"
		valid_options += "Species"

		if(chargen_options & CHARGEN_SEX)
			valid_options += "Sex"

		if(chargen_options & CHARGEN_COLOR_SKIN)
			valid_options += "Skin Color"

		if(chargen_options & CHARGEN_COLOR_DETAIL)
			valid_options += "Detail Color"

		if(chargen_options & CHARGEN_COLOR_GLOW)
			valid_options += "Glow Color"

		if(chargen_options & CHARGEN_COLOR_EYE)
			valid_options += "Eye Color"

		if(chargen_options & CHARGEN_STYLE_HAIR)
			valid_options += "Hair Style"

		if(chargen_options & CHARGEN_COLOR_HAIR)
			valid_options += "Hair Color"

		valid_options += "Cancel"

		var/response = input(caller,"Would you like to change your appearance?") in valid_options
		INTERACT_CHECK
		switch(response)
			if("Cancel")
				break

			if("Name")
				while(TRUE)
					var/name_input = sanitize(input(caller,"Which do you wish to be known by?"))
					INTERACT_CHECK
					A.name = name_input
					var/confirm = input(caller,"You are [name_input]. Are you sure you wish to be known as [name_input]?") in list("Yes","No")
					INTERACT_CHECK
					if(confirm == "Yes")
						break

			if("Species")
				var/warning = input("Are you sure you wish to change your species? All other changes will be lost.") in list("Yes","No")
				INTERACT_CHECK
				if(warning == "Yes")
					while(TRUE)
						var/list/species_options = list()
						for(var/id in chargen_species)
							var/datum/species/Sp = chargen_species[id]
							species_options[Sp.name] = Sp

						var/chosen_species = input("Which species do you wish to be?") in species_options
						INTERACT_CHECK
						var/list/clothing_list = A.drop_all_items()
						A.mob_species = species_options[chosen_species]
						A.update_species()
						A.equip_objects_in_list(clothing_list)


						var/confirm = input(caller,"Do you like your species?") in list("Yes, keep it.","No, I want a new one.")
						INTERACT_CHECK
						if(confirm == "Yes, keep it.")
							break

			if("Sex")
				var/warning = input("Are you sure you wish to change your sex? All other changes will be lost.") in list("Yes","No")
				INTERACT_CHECK
				if(warning == "Yes")
					while(TRUE)
						var/sex = input("Which sex do you wish to have?") in list("Male","Female")
						INTERACT_CHECK
						var/list/clothing_list = A.drop_all_items()
						A.gender = sex == "Female" ? FEMALE : MALE
						A.update_gender()
						A.equip_objects_in_list(clothing_list)

						A.add_clothes(A.mob_outfit)
						A.dir = SOUTH

						var/confirm = input(caller,"Do you like your sex?") in list("Yes, keep it.","No, I want a new one.")
						INTERACT_CHECK
						if(confirm == "Yes, keep it.")
							break

			if("Hair Style")
				if(!A.labeled_organs[BODY_HAIR_HEAD])
					A.to_chat("You don't have any hair!")
					continue
				var/obj/item/organ/hair/O = A.labeled_organs[BODY_HAIR_HEAD]
				var/list/name_to_id = list()

				for(var/id in hair_types)
					var/hair/H = hair_types[id]
					if(A.mob_species.flags_species & H.species)
						name_to_id[H.name] = id

				while(TRUE)
					var/hair_style = input(caller,"Which hair style do you wish to have?") in name_to_id
					INTERACT_CHECK
					O.style = name_to_id[hair_style]
					A.update_icon()
					A.dir = SOUTH
					var/confirm = input(caller,"Do you like your hair_style?") in list("Yes, keep it.","No, I want a new one.")
					INTERACT_CHECK
					if(confirm == "Yes, keep it.")
						break

			if("Hair Color")
				if(!A.labeled_organs[BODY_HAIR_HEAD])
					A.to_chat("You don't have any hair!")
					continue
				var/obj/item/organ/hair/O = A.labeled_organs[BODY_HAIR_HEAD]
				var/list/valid_colors = A.mob_species.chargen_hair_colors

				while(TRUE)
					var/color_hair = input(caller,"Which hair color do you wish to have?") in valid_colors
					INTERACT_CHECK
					O.color_skin = valid_colors[color_hair]
					A.update_icon()
					A.dir = SOUTH
					var/confirm = input(caller,"Do you like your hair color?") in list("Yes, keep it.","No, I want a new one.")
					INTERACT_CHECK
					if(confirm == "Yes, keep it.")
						break

			if("Skin Color")
				var/list/valid_colors = A.mob_species.chargen_skin_colors
				while(TRUE)
					var/color_skin = input(caller,"Which skin color do you wish to have?") in valid_colors
					INTERACT_CHECK
					A.change_color_skin(valid_colors[color_skin])
					A.dir = SOUTH
					var/confirm = input(caller,"Do you like your skin color?") in list("Yes, keep it.","No, I want a new one.")
					INTERACT_CHECK
					if(confirm == "Yes, keep it.")
						break

			if("Glow Color")
				var/list/valid_colors = A.mob_species.chargen_glow_colors
				while(TRUE)
					var/color_glow = input(caller,"Which skin color do you wish to have?") in valid_colors
					INTERACT_CHECK
					A.change_glow_color(valid_colors[color_glow])
					A.dir = SOUTH
					var/confirm = input(caller,"Do you like your glow color?") in list("Yes, keep it.","No, I want a new one.")
					INTERACT_CHECK
					if(confirm == "Yes, keep it.")
						break

			if("Detail Color")
				var/list/valid_colors = A.mob_species.chargen_detail_colors
				while(TRUE)
					var/color_detail = input(caller,"Which detail color do you wish to have?") in valid_colors
					INTERACT_CHECK
					A.change_secondary_color(valid_colors[color_detail])
					A.dir = SOUTH
					var/confirm = input(caller,"Do you like your detail color?") in list("Yes, keep it.","No, I want a new one.")
					INTERACT_CHECK
					if(confirm == "Yes, keep it.")
						break

			if("Eye Color")
				var/list/valid_colors = A.mob_species.chargen_eye_colors

				while(TRUE)
					var/eye_color = input(caller,"Which eye color do you wish to have?") in valid_colors
					INTERACT_CHECK
					A.change_eye_color(valid_colors[eye_color])
					A.dir = SOUTH
					var/confirm = input(caller,"Do you like your eye color?") in list("Yes, keep it.","No, I want a new one.")
					INTERACT_CHECK
					if(confirm == "Yes, keep it.")
						break

	return TRUE