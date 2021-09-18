/obj/hud/button/widget/

	name = "widget"

	essential = TRUE

	flags = FLAGS_HUD_WIDGET

	mouse_opacity = 1

	icon = 'icons/hud/hud.dmi'

	has_quick_function = FALSE

/obj/hud/button/widget/experience
	name = "Check Experience"
	icon_state = "xp_new"
	screen_loc = "RIGHT-1,TOP"

/obj/hud/button/widget/experience/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_living(caller))

		var/final_text = ""

		var/mob/living/L = caller

		var/job/J
		var/job_rank = 0
		if(is_player(L))
			var/mob/living/advanced/player/P = L
			J = JOB(P.job)
			if(J)
				job_rank = P.job_rank
				final_text += div("bold underlined","Job:\n")
				final_text += div("notice","[J.get_rank_title(job_rank)] (Rank: [job_rank])\n")

		final_text += div("bold underlined","Attributes\n")
		for(var/k in L.attributes)
			var/experience/attribute/A = L.attributes[k]
			var/current_level = A.get_current_level()
			var/current_xp = A.get_xp()
			var/last_xp = A.level_to_xp(current_level)
			var/next_xp = A.level_to_xp(min(current_level+1,A.get_max_level()))
			var/information_link = "<a href='?examine=\ref[A]'>?</a>"
			var/bonus = ""
			if(J && J.bonus_attributes[k])
				bonus = "<b>(+[J.bonus_attributes[k]*job_rank])</b>"
			if(next_xp - last_xp > 0)
				final_text += div("notice","[A.name] ([information_link]): [A.get_current_level(current_level)][bonus] ([current_xp - last_xp]/[next_xp - last_xp]xp)\n")
			else
				final_text += div("notice","[A.name] ([information_link]): <b>[A.get_current_level(current_level)][bonus]</b>\n")

		final_text += div("bold underlined","Skills\n")
		for(var/k in L.skills)
			var/experience/skill/A = L.skills[k]
			var/current_level = A.get_current_level()
			var/current_xp = A.get_xp()
			var/last_xp = A.level_to_xp(current_level)
			var/next_xp = A.level_to_xp(min(current_level+1,A.get_max_level()))
			var/information_link = "<a href='?examine=\ref[A]'>?</a>"
			var/prestige_text = ""
			var/bonus = ""
			if(J && J.bonus_skills[k])
				bonus = "<b>(+[J.bonus_skills[k]*job_rank])</b>"
			if(is_player(L))
				var/mob/living/advanced/player/P = L
				if(P.prestige_count[k])
					prestige_text = " Prestige [P.prestige_count[k]]\Roman"

			if(next_xp - last_xp > 0)
				final_text += div("notice","[A.name] ([information_link]): [A.get_current_level(current_level)][bonus][prestige_text] ([current_xp - last_xp]/[next_xp - last_xp]xp)\n")
			else
				final_text += div("notice","[A.name] ([information_link]): <b>[A.get_current_level(current_level)][bonus][prestige_text]</b>\n")
		L.to_chat(final_text)


/obj/hud/button/widget/logout
	name = "Logout"
	icon_state = "logout_new"
	screen_loc = "RIGHT,TOP"

/obj/hud/button/widget/logout/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	. = ..()

	if(. && is_player(caller))
		var/mob/living/advanced/player/P = caller
		P.try_logout()


/obj/hud/button/widget/change_theme
	name = "Change Theme"
	icon_state = "theme_new"
	screen_loc = "RIGHT-2,TOP"

/obj/hud/button/widget/change_theme/clicked_on_by_object(var/mob/caller,var/atom/object,location,control,params)

	if(!is_player(caller))
		return ..()

	var/mob/living/advanced/player/P = caller

	if(/obj/hud/button/close_color_scheme in P.buttons)
		return ..()

	P.add_color_scheme_buttons()

	return ..()