/obj/hud/button/widget/

	name = "widget"

	essential = TRUE

	flags = FLAGS_HUD_WIDGET

	mouse_opacity = 1

	icon = 'icons/hud/widget.dmi'

	has_quick_function = FALSE

/obj/hud/button/widget/experience
	name = "Check Experience"
	icon_state = "experience"
	screen_loc = "RIGHT,TOP"

/obj/hud/button/widget/experience/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_living(caller))
		return TRUE

	var/final_text = ""

	var/mob/living/L = caller

	final_text += div("bold underlined","Attributes\n")

	for(var/k in L.attributes)
		var/experience/attribute/A = L.attributes[k]
		var/current_level = A.get_current_level()
		final_text += div("notice","[A.name]: [A.get_current_level(current_level)]\n")

	final_text += div("bold underlined","Skills\n")

	for(var/k in L.skills)
		var/experience/skill/S = L.skills[k]
		var/current_level = S.get_current_level()
		final_text += div("notice","[S.name]: [S.get_current_level(current_level)] ([S.level_to_xp(current_level)]/[S.level_to_xp(min(current_level+1,S.max_level))] xp)\n")

	L.to_chat(final_text)

	return ..()

/obj/hud/button/widget/logout
	name = "Logout"
	icon_state = "logout"
	screen_loc = "RIGHT,TOP"

/obj/hud/button/widget/logout/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(is_player(caller))
		var/mob/living/advanced/player/P = caller
		P.logout()

	return ..()

/obj/hud/button/widget/change_theme
	name = "Change Theme"
	icon_state = "change_theme"
	screen_loc = "RIGHT,TOP"

/obj/hud/button/widget/change_theme/clicked_on_by_object(var/mob/caller,object,location,control,params)

	if(!is_player(caller))
		return ..()

	var/mob/living/advanced/player/P = caller

	if(/obj/hud/button/close_color_scheme in P.buttons)
		return ..()

	P.add_color_scheme_buttons()

	return ..()