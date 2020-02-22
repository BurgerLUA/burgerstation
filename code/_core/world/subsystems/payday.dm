var/global/stored_payday = 0

/subsystem/payday/
	name = "Payday Subsystem"
	desc = "How people get paid."
	priority = SS_ORDER_LAST
	tick_rate = SECONDS_TO_TICKS(60)

	var/next_payday = -1

/subsystem/payday/Initialize()
	next_payday = world.time + SECONDS_TO_DECISECONDS(10)
	return TRUE

/subsystem/payday/on_life()

	if(next_payday > 0 && world.time >= next_payday)

		stored_payday *= 0.25 //Prevents gaming the system.

		var/list/mob/living/advanced/player/valid_players = list()

		for(var/mob/living/advanced/player/P in world)
			if(P.iff_tag != "NanoTrasen" || !P.client || P.dead)
				continue
			valid_players += P

		for(var/mob/living/advanced/player/P in valid_players)
			var/bonus_to_give = Clamp(floor(stored_payday/length(valid_players)),0,400)
			P.adjust_currency( 200 + bonus_to_give )
			if(bonus_to_give)
				P.to_chat(span("payday","Hazard Pay! You have earned 200 credits and a [bonus_to_give] credit bonus from cargo deliveries!"))
			else
				P.to_chat(span("payday","Hazard Pay! You have earned 200 credits for your efforts."))

		next_payday = world.time + SECONDS_TO_DECISECONDS(600)

		stored_payday = 0

	return TRUE


