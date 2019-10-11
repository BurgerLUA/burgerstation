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

	var/spam_protection_command = 0
	//Increases by a certain amount every time something is used.
	//Measured in seconds.
	//Reduces by 1 every second.

	var/last_track_time = -1

	var/spawn_protection = 0

	respawn = FALSE

	has_hard_crit = TRUE

	movement_delay = DECISECONDS_TO_TICKS(2)

	var/list/attack_logs = list()

	var/currency = 0

	var/savedata/client/mob/mobdata

	var/logout_time = 0

	health_base = 100
	stamina_base = 100
	mana_base = 100

/mob/living/advanced/player/apply_mob_parts()

	if(!mobdata || mobdata.loaded_data["tutorial"])
		return ..()

	mobdata.apply_data_to_mob(src)
	return TRUE

/mob/living/advanced/player/Initialize()

	. = ..()

	all_players += src
	name = "[real_name] ([ckey])"
	return .

/mob/living/advanced/player/destroy()
	all_players -= src
	qdel(mobdata)
	mobdata = null
	attack_logs.Cut()
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