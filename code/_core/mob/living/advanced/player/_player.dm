var/list/mob/living/advanced/player/all_players

/mob/living/advanced/player/
	name = "lost soul"
	desc = "Seems a little smarter than most, you think."
	desc_extended = "This is a player."

	starting_factions = list(
		FACTION_PLAYER
	)
	class = "default"

	var/dialogue_target_id

	invisibility = INVISIBILITY_PLAYERS

/mob/living/advanced/player/Initialize()
	..()
	all_players += src

/mob/living/advanced/player/destroy()
	..()
	all_players -= src


/mob/living/advanced/player/Cross(var/atom/moveable/A)
	return is_safezone(area) || intent == INTENT_HARM


/mob/living/advanced/player/Move(var/atom/new_loc,var/desired_dir=0,var/desired_step_x=0,var/desired_step_y=0)
	. = ..()
	if(. && dialogue_target_id)
		dialogue_target_id = null
		close_menu(src,"dialogue")

	return .

/mob/living/advanced/player/verb/progress_debug()
	set name = "Progress Bar Debug"
	set category = "Debug"
	add_progress_bar(src,"test",60)

/mob/living/advanced/player/verb/class_debug()
	set name = "Class Debug"
	set category = "Debug"
	open_menu(src,"class_editor")
