/obj/hud/button/mood
	name = "mood"
	desc = "Mooooooooooooooood."
	desc_extended = "An average indication of your mental state. Can be improved by eating tasty food or drinking tasty drinks."
	icon = 'icons/hud/mood.dmi'
	icon_state = "100"
	screen_loc = "RIGHT-1,CENTER"
	flags_hud = FLAG_HUD_MOB
	layer = 100 //Makes it above the hunger meter.
	screen_loc = "RIGHT:-1,CENTER-1:-4"
	var/last_mood = 50

/obj/hud/button/mood/update_sprite()
	. = ..()
	switch(last_mood)
		if(-INFINITY to 10)
			color = "#FF0000"
			icon_state = "0"
		if(10 to 25)
			color = "#FF6A00"
			icon_state = "0"
		if(25 to 50)
			color = "#FFD800"
			icon_state = "25"
		if(50 to 75)
			color = "#0095FC"
			icon_state = "50"
		if(75 to 90)
			color = "#1FC096"
			icon_state = "75"
		if(90 to 100)
			color = "#2ED564"
			icon_state = "100"
		if(100 to INFINITY)
			color = "#4CFF00"
			icon_state = "100"