var/global/list/mob/living/advanced/player/all_players = list()

/mob/living/advanced/player/
	name = "lost soul"
	var/real_name = "lost soul"
	desc = "Seems a little smarter than most, you think."
	desc_extended = "This is a player."

	starting_factions = list(
		FACTION_PLAYER
	)
	class = "default"

	var/dialogue_target_id

	invisibility = INVISIBILITY_PLAYERS

	sight = SEE_BLACKNESS | SEE_SELF | SEE_TURFS | SEE_PIXELS

	var/spam_protection_command = 0
	//Increases by a certain amount every time something is used.
	//Measured in seconds.
	//Reduces by 1 every second.

	movement_delay = 4 //Basically the minimum movement delay. Measured in ticks.

	var/last_track_time = -1

	var/spawn_protection = 0

	respawn = FALSE

/mob/living/advanced/player/Initialize()
	. = ..()
	all_players += src
	name = "[real_name] ([ckey])"
	return .

/mob/living/advanced/player/destroy()
	all_players -= src
	return ..()

mob/living/advanced/player/on_life_client()
	..()
	spam_protection_command = max(0,spam_protection_command-TICKS_TO_SECONDS(1))

/mob/living/advanced/player/Move(NewLoc,Dir=0,step_x=0,step_y=0)
	. = ..()
	if(. && dialogue_target_id)
		dialogue_target_id = null
		close_menu(src,"dialogue")

	if(.)
		for(var/mob/living/L in view(src,VIEW_RANGE))
			if(!L.ai)
				continue
			var/ai/AI = L.ai
			AI.enabled = TRUE

	return .

/*
/mob/living/advanced/player/verb/progress_debug()
	set name = "Progress Bar Debug"
	set category = "Debug"
	add_progress_bar(src,"test",60)

/mob/living/advanced/player/verb/class_debug()
	set name = "Class Debug"
	set category = "Debug"
	open_menu(src,"class_editor")

/mob/living/advanced/player/verb/spawn_player()
	set name = "Spawn Player"
	set category = "Debug"

	var/mob/living/advanced/player/fake/F = new(src.loc)
	F.Initialize()
*/