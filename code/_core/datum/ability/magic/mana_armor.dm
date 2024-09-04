/ability/magic/mana_armor
	name = "toggle mana armor"
	desc = "A togglable ability that adds 25% of your total overall arcane armor rating to your overall blunt, blade, and pierce armor rating as long as you have more mana than half of your maximum mana. Taking damage removes mana equal to the amount of blunt, blade and pierce damage dealt."
	icon_state = "mana_armor"
	cost = 25
	cooldown = SECONDS_TO_DECISECONDS(3)

	toggle = TRUE

/ability/magic/mana_armor/is_active(var/mob/caller)

	if(is_living(caller))
		var/mob/living/L = caller
		return L.has_status_effect(MANA_ARMOR)

	return FALSE

/ability/magic/mana_armor/on_cast(var/mob/caller,var/atom/target,location,params)
	. = ..()
	if(. && is_living(caller))
		var/mob/living/L = caller
		if(L.has_status_effect(MANA_ARMOR))
			L.remove_status_effect(MANA_ARMOR)
		else
			L.add_status_effect(MANA_ARMOR,25,-1,L,TRUE,FALSE,TRUE)