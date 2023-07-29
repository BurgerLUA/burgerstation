/mob/living/advanced/player/unsc/
	var/loadout/loadout_to_use
	class = /class/player/unsc
	allow_save = FALSE

	level = 40

/mob/living/advanced/player/unsc/on_add_xp(var/experience/E,var/added_xp)

	. = ..()

	if(added_xp > 0 && client) //Don't give rewards to afk players.
		var/savedata/client/globals/GD = GLOBALDATA(client.ckey)
		if(!GD) return FALSE
		if(!GD.loaded_data["stored_experience"])
			GD.loaded_data["stored_experience"] = list()
		GD.loaded_data["stored_experience"][E.id] += added_xp

/mob/living/advanced/player/unsc/proc/hook_faction()
	HOOK_ADD("post_death", "faction_ticket", src, src, .proc/unsc_point_loss)
	return TRUE

/mob/living/advanced/player/unsc/proc/unsc_point_loss()
	var/gamemode/gamemode = SSgamemode.active_gamemode
	if(!isnull(gamemode.team_points[TEAM_UNSC]))
		gamemode.team_points[TEAM_UNSC] -= 1
		for(var/obj/hud/button/ticket_counter/ticket_counter as anything in hud_ticket_counters)
			ticket_counter.update_maptext()
	gamemode.update_points()


/mob/living/advanced/player/unsc/adjust_currency(var/currency_to_add,var/tax=FALSE)

	. = ..()

	if(currency_to_add > 0 && client) //Don't give rewards to afk players.
		var/savedata/client/globals/GD = GLOBALDATA(client.ckey)
		if(GD) GD.loaded_data["stored_currency"] += currency_to_add
