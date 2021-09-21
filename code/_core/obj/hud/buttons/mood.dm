/obj/hud/button/mood
	name = "mood"
	desc = "Mooooooooooooooood."
	desc_extended = "An average indication of your mental state. Can be improved by eating tasty food or drinking tasty drinks."
	icon = 'icons/hud/mood.dmi'
	icon_state = "100"
	screen_loc = "RIGHT-1,CENTER"
	flags = FLAGS_HUD_MOB
	layer = 100 //Makes it above the hunger meter.
	screen_loc = "RIGHT,BOTTOM+4:-14"
	var/last_mood = 0


/obj/hud/button/mood/update_sprite()
	. = ..()

	if(!is_advanced(owner))
		return .
	var/mob/living/advanced/A = owner
	last_mood = A.mood
	switch(A.mood)
		if(-INFINITY to 50)
			color = "#FF0000"
			icon_state = "50"
		if(50 to 75)
			color = "#FF6A00"
			icon_state = "50"
		if(75 to 99)
			color = "#FFD800"
			icon_state = "75"
		if(99 to 101)
			color = "#0095FC"
			icon_state = "100"
		if(101 to 125)
			color = "#1FC096"
			icon_state = "125"
		if(125 to 150)
			color = "#2ED564"
			icon_state = "150"
		if(150 to INFINITY)
			color = "#4CFF00"
			icon_state = "150"

/obj/hud/button/mood/get_examine_list(var/mob/caller)
	. = ..()
	if(is_advanced(caller))
		var/mob/living/advanced/A = caller
		. += "Your mood is [CEILING(A.mood,1)]%."
		var/mood_gain = (A.last_mood_gain/TICKS_TO_SECONDS(LIFE_TICK_SLOW))*60
		. += "You are [mood_gain >= 0 ? "gaining" : "losing"] [abs(round(mood_gain,0.01))] mood per minute."