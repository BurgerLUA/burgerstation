/status_effect/soul_trap
	name = "Soul Trap"
	desc = "You've been soul trapped!"
	id = SOULTRAP
	minimum = SECONDS_TO_DECISECONDS(4)
	maximum = SECONDS_TO_DECISECONDS(60)
	default_duration = SECONDS_TO_DECISECONDS(30)

	affects_dead = FALSE

/status_effect/soul_trap/can_add_status_effect(var/atom/attacker,var/mob/living/victim)

	if(!victim.can_be_soultrapped())
		return FALSE

	. = ..()

/mob/living/proc/can_be_soultrapped()

	if(!ai) //Soulless, pretty much.
		return FALSE

	if(delete_on_death) //Some weird bullshit.
		return FALSE

	if(minion_master) //Soul belongs to someone else.
		return FALSE

	if(!soul_size || soul_size <= 0) //Error soul.
		return FALSE

	if(initial(anchored)) //Likely a machine.
		return FALSE

	if(is_player_controlled()) //Controlled by a player.
		return FALSE

	return TRUE

/mob/living/advanced/can_be_soultrapped()
	return FALSE