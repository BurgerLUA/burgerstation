/obj/hud/button/mood
	name = "mood"
	desc = "Mooooooooooooooood."
	desc_extended = "An average indication of your mental state. Can be improved by eating and drinking healthy."
	icon = 'icons/hud/mood.dmi'
	icon_state = "100"
	screen_loc = "RIGHT-1,CENTER"
	flags_hud = FLAG_HUD_MOB
	layer = 100 //Makes it above the hunger meter.
	screen_loc = "RIGHT:-1,CENTER-1:-4"
	var/last_mood = 50
	user_colors = FALSE

/obj/hud/button/mood/update_icon()

	switch(last_mood)
		if(-INFINITY to 10)
			color = "#FF0000" //Red
			icon_state = "0"
		if(10 to 25)
			color = "#FF6A00" //Orange
			icon_state = "0"
		if(25 to 50)
			color = "#FFD800" //Yellow
			icon_state = "25"
		if(50 to 75)
			color = "#0095FC" //Blue
			icon_state = "50"
		if(75 to 90)
			color = "#1FC096" //Teal
			icon_state = "75"
		if(90 to 100)
			color = "#2ED564" //Green
			icon_state = "100"
		if(100 to INFINITY)
			color = "#4CFF00" //Greener
			icon_state = "100"

	. = ..()


/obj/hud/button/mood/get_examine_list(var/mob/caller)

	. = ..()

	. += "Your overall mood is [src.last_mood]%."