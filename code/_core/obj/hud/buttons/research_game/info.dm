/obj/hud/button/research/info
	name = "info"
	icon = 'icons/hud/hud.dmi'
	icon_state = "square_round"
	maptext = "<center>Info</center>"

/obj/hud/button/research/info/time
	name = "time left"
	screen_loc = "LEFT,TOP"
	maptext = "<center>Time:<br>1:00</center>"

/obj/hud/button/research/info/level
	name = "current level"
	screen_loc = "LEFT,TOP-1"
	maptext = "<center>Level:<br>1</center>"

/obj/hud/button/research/info/score
	name = "score"
	screen_loc = "LEFT,TOP-2"
	maptext = "<center>Score:<br>0</center>"

/obj/hud/button/research/info/effect
	name = "text"
	screen_loc = "CENTER,CENTER"
	icon_state = "none"
	maptext = "<center>+1</center>"
	layer = 99

/obj/hud/button/research/info/quit
	name = "quit button"
	screen_loc = "TOP,RIGHT"
	icon_state = "square_round_small"
	maptext = "<center>Quit</center>"
	layer = 99
	mouse_opacity = 1

/obj/hud/button/research/info/quit/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_living(caller))
		var/mob/living/L = caller
		L.toggle_research_game(TRUE,FALSE)

	return TRUE

/obj/hud/button/research/info/effect/proc/do_effect(var/obj/hud/button/research/piece/P,var/points_given)
	maptext = "<center><font size=2>+[points_given]</font></center>"
	screen_loc = P.screen_loc
	var/direction = pick(-1,1)
	animate(src,maptext_x = direction*TILE_SIZE*2, maptext_y = RESEARCH_BOARD_SIZE*TILE_SIZE, easing = QUAD_EASING | EASE_OUT, time = 5*RESEARCH_BOARD_SIZE)
	spawn(10*RESEARCH_BOARD_SIZE)
		update_owner(null)
	return TRUE

/obj/hud/button/research/info/text
	name = "text"
	screen_loc = "CENTER,CENTER"
	icon_state = "none"

	maptext = null
	maptext_x = -(TILE_SIZE*VIEW_RANGE) + 16
	maptext_width = TILE_SIZE*VIEW_RANGE*2
	maptext_height = TILE_SIZE*VIEW_RANGE

	mouse_opacity = 0

	layer = 100 //I don't give a fuck.