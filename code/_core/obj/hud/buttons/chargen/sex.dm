/obj/hud/button/chargen/sex/
	icon_state = "square_round"
	screen_loc = "CENTER,CENTER"

	var/sex_button = MALE

/obj/hud/button/chargen/sex/clicked_by_object(var/mob/caller,object,location,control,params)

	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/choice = input("Are you sure you want to change your sex? Your appearance will reset to default.","Sex Change") in list("Yes","No")

		if(choice == "Yes")
			A.perform_sexchange(sex_button,!A.clothing_changed)

	return TRUE

/obj/hud/button/chargen/sex/male
	name = "change sex to male"
	icon_state = "male"
	screen_loc = "CENTER-2,CENTER+0"

	sex_button = MALE

/obj/hud/button/chargen/sex/female
	name = "change sex to female"
	icon_state = "female"
	screen_loc = "CENTER+2,CENTER+0"

	sex_button = FEMALE