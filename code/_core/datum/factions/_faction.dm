/faction/
	var/name = "Faction"
	var/desc = "The faction's description."
	id = "default"

	var/priority = 0 //A higher value = overrides lower values
	var/color = "#FFFFFF"

	var/icon
	var/icon_state

	var/list/relationships = list()

	var/aggressiveness = ATTACK_ENEMIES

	var/friendly_fire = TRUE //Set to true if people can kill eachother in this faction.

/faction/proc/is_hostile_to(var/faction/F)
	if(length(relationships) && relationships[F.id])
		return relationships[F.id] <= aggressiveness
	else
		return FALSE

/faction/proc/is_hostile_to_mob(var/mob/living/L)
	for(var/id in L.factions)
		if(relationships[id] && relationships[id] <= aggressiveness)
			return TRUE

	return FALSE

/faction/proc/can_damage_team()
	return friendly_fire