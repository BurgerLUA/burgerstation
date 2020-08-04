#define BASE_PAY 200


SUBSYSTEM_DEF(payday)
	name = "Payday Subsystem"
	desc = "How people get paid."
	priority = SS_ORDER_LAST
	tick_rate = SECONDS_TO_TICKS(60)

	var/next_payday = -1
	var/stored_payday = 0

	tick_usage_max = 50
	cpu_usage_max = 50

/subsystem/payday/Initialize()
	next_payday = world.time + SECONDS_TO_DECISECONDS(300)
	return ..()

/subsystem/payday/on_life()

	if(next_payday > 0 && world.time >= next_payday)
		trigger_payday()

	return TRUE

/subsystem/payday/proc/trigger_payday()

	var/list/mob/living/advanced/player/valid_players = list()

	for(var/mob/living/advanced/player/P in all_players)
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		if(P.loyalty_tag != "NanoTrasen" || !P.client || P.dead)
			continue
		valid_players += P
		var/tax = FLOOR(P.currency * 0.05,10)
		if(tax)
			P.adjust_currency( -tax )
			P.to_chat(span("notice","You were taxed 5% of your wealth ([tax] credits)."))

	stored_payday *= 0.5 //Prevents gaming the system.

	for(var/mob/living/advanced/player/P in valid_players)
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		var/bonus_to_give = clamp(FLOOR(stored_payday/length(valid_players), 1),0,10000)
		P.adjust_currency( BASE_PAY + bonus_to_give )
		if(bonus_to_give)
			P.to_chat(span("payday","Hazard Pay! You have earned [BASE_PAY] credits and a [bonus_to_give] credit bonus."))
		else
			P.to_chat(span("payday","Hazard Pay! You have earned [BASE_PAY] credits for your efforts."))

	next_payday = world.time + SECONDS_TO_DECISECONDS(600)

	stored_payday = 0