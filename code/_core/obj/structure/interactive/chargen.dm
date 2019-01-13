obj/structure/interactive/chargen_mirror
	name = "magic mirror"
	desc = "A magic mirror. This probably does something."
	density = 0
	icon = 'icons/obj/structure/medieval/bathroom.dmi'
	icon_state = "mirror"

obj/structure/interactive/chargen_mirror/activate(caller,location,control,params)

	if(!is_advanced(caller))
		return FALSE

	var/mob/living/advanced/A = caller

	while(TRUE)
		var/response = input(caller,"Would you like to change your appearance?") in list("Name","Sex","Eye Color","Skin Color","Hair Style","Hair Color","Cancel")
		switch(response)
			if("Cancel")
				break

			if("Name")
				while(TRUE)
					var/name_input = sanitize(input(caller,"Which do you wish to be known by?"))
					A.name = name_input
					var/confirm = input(caller,"You are [name_input]. Are you sure you wish to be known as [name_input]?") in list("Yes","No")
					if(confirm == "Yes")
						break

			if("Sex")
				var/warning = input("Are you sure you wish to change your sex? All other changes will be lost.") in list("Yes","No")
				if(warning == "Yes")
					while(TRUE)
						var/sex = input("Which sex do you wish to have?") in list("Male","Female")
						A.gender = sex == "Female" ? FEMALE : MALE
						A.update_gender()
						if(A.gender == FEMALE)
							A.mob_outfit = new /datum/outfit/new_character_female
						else
							A.mob_outfit = new /datum/outfit/new_character

						A.add_clothes(A.mob_outfit)
						A.dir = SOUTH

						var/confirm = input(caller,"Do you like your sex?") in list("Yes, keep it.","No, I want a new one.")
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
					name_to_id[H.name] = id
				while(TRUE)
					var/hair_style = input(caller,"Which hair style do you wish to have?") in name_to_id
					O.hairstyle = name_to_id[hair_style]
					A.update_icon()
					A.dir = SOUTH
					var/confirm = input(caller,"Do you like your hairstyle?") in list("Yes, keep it.","No, I want a new one.")
					if(confirm == "Yes, keep it.")
						break

			if("Hair Color")
				if(!A.labeled_organs[BODY_HAIR_HEAD])
					A.to_chat("You don't have any hair!")
					continue
				var/obj/item/organ/hair/O = A.labeled_organs[BODY_HAIR_HEAD]
				var/list/valid_colors = list(
					"black" = "#ffffff",
					"grey" = "#5e5954",
					"dark brown" = "#60330d",
					"blond" = "#d3c276",
					"light brown" = "#9e5625"
				)
				while(TRUE)
					var/hair_color = input(caller,"Which hair color do you wish to have?") in valid_colors
					O.color = valid_colors[hair_color]
					A.update_icon()
					A.dir = SOUTH
					var/confirm = input(caller,"Do you like your hair color?") in list("Yes, keep it.","No, I want a new one.")
					if(confirm == "Yes, keep it.")
						break

			if("Skin Color")
				var/list/valid_colors = list(
					"pale" = "#fff3e8",
					"white" = "#ffd6ba",
					"tan" = "#e0b19d",
					"dark" = "#bc9784",
					"darker" = "#997563",
					"ebony" = "#63493c",
					"black" = "#35241c"
				)

				while(TRUE)
					var/skin_color = input(caller,"Which skin color do you wish to have?") in valid_colors
					A.change_skin_color(valid_colors[skin_color])
					A.dir = SOUTH
					var/confirm = input(caller,"Do you like your skin color?") in list("Yes, keep it.","No, I want a new one.")
					if(confirm == "Yes, keep it.")
						break

			if("Eye Color")
				var/list/valid_colors = list(
					"black" = "#000000",
					"blue" = "#66c4ff",
					"brown" = "#6b431f",
					"dark brown" = "#3d220a",
					"green" = "#435b1d",
					"grey" = "#999999"
				)

				while(TRUE)
					var/eye_color = input(caller,"Which eye color do you wish to have?") in valid_colors
					A.change_eye_color(valid_colors[eye_color])
					A.dir = SOUTH
					var/confirm = input(caller,"Do you like your eye color?") in list("Yes, keep it.","No, I want a new one.")
					if(confirm == "Yes, keep it.")
						break

	return TRUE