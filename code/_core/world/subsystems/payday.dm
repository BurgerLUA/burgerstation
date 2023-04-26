#define BASE_PAY 500

SUBSYSTEM_DEF(payday)
	name = "Payday Subsystem"
	desc = "How people get paid."
	priority = SS_ORDER_LAST
	tick_rate = SECONDS_TO_TICKS(60)

	var/next_payday = -1
	var/stored_payday = 0

	tick_usage_max = 50

/subsystem/payday/Initialize()
	next_payday = world.time + SECONDS_TO_DECISECONDS(180)
	return ..()

/subsystem/payday/on_life()

	if(next_payday > 0 && world.time >= next_payday)
		trigger_payday()

	return TRUE

/subsystem/payday/proc/trigger_payday()

	var/list/mob/living/advanced/player/valid_players = list()

	for(var/k in all_players)
		var/mob/living/advanced/player/P = k
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)
		if(P.loyalty_tag != "NanoTrasen" || !P.client || P.dead || !P.allow_save)
			continue
		valid_players += P
		if(P.insurance_premiums)
			var/tax = CEILING(P.currency * P.insurance_premiums,1)
			if(tax)
				var/charged_amount = -P.adjust_currency( -(tax + 50) )
				P.insurance += FLOOR(charged_amount*1,1)
				P.to_chat(span("notice","You were taxed your insurance premium of <b>[charged_amount] credits</b>. Your insurance pool is now <b>[P.insurance] credits</b>."))
				P.update_premiums()

	stored_payday *= 0.25 //Prevents gaming the system.

	for(var/k in valid_players)
		var/mob/living/advanced/player/P = k
		CHECK_TICK_SAFE(tick_usage_max,FPS_SERVER)
		if(!P.job)
			P.to_chat(span("payday warning","Warning: No job detected! Speak to the Head of Personnel to get one!"))
			continue
		var/job/J = JOB(P.job)
		var/bonus_to_give = clamp(stored_payday/length(valid_players),0,5000)
		bonus_to_give = FLOOR(bonus_to_give,1)
		var/base_pay = J.passive_income + J.passive_income_bonus*(P.job_rank - 1)
		if(bonus_to_give)
			P.to_chat(span("payday","Hazard Pay! You have earned [base_pay] credits and a [bonus_to_give] credit bonus."))
		else
			P.to_chat(span("payday","Hazard Pay! You have earned [base_pay] credits for your efforts."))
		P.adjust_currency(bonus_to_give + base_pay)


















	next_payday = world.time + SECONDS_TO_DECISECONDS(300)

	stored_payday = 0