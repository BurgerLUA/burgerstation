/obj/hud/button/chargen/sex/
	name = "change sex"
	desc_extended = "Click here to change your character's sex. Note that changing your character's sex will cause you to lose your previous changes."
	icon_state = "change_sex"
	screen_loc = "CENTER-2,CENTER+0"
	user_colors = TRUE

	chargen_flags = CHARGEN_SEX

/obj/hud/button/chargen/sex/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()


	if(. && is_advanced(caller))
		var/mob/living/advanced/A = caller
		var/desired_sex = A.sex == MALE ? FEMALE : MALE
		var/choice = input("Are you sure you want to change your sex to [desired_sex == MALE ? "male" : "female"]? Your appearance will reset to default.","Sex Change") in list("Yes","No")

		if(choice == "Yes")
			A.perform_sexchange(desired_sex,TRUE,TRUE)
