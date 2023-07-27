/mob/living/advanced/player/urf/
	var/loadout/loadout_to_use
	class = /class/player/urf
	allow_save = FALSE

	level = 40

/mob/living/advanced/player/urf/on_add_xp(var/experience/E,var/added_xp)

	. = ..()

	if(added_xp > 0 && client) //Don't give rewards to afk players.
		var/savedata/client/globals/GD = GLOBALDATA(client.ckey)
		if(!GD) return FALSE
		if(!GD.loaded_data["stored_experience"])
			GD.loaded_data["stored_experience"] = list()
		GD.loaded_data["stored_experience"][E.id] += added_xp

/mob/living/advanced/player/urf/adjust_currency(var/currency_to_add,var/tax=FALSE)

	. = ..()

	if(currency_to_add > 0 && client) //Don't give rewards to afk players.
		var/savedata/client/globals/GD = GLOBALDATA(client.ckey)
		if(GD) GD.loaded_data["stored_currency"] += currency_to_add

