#define BASE_PAY 500

SUBSYSTEM_DEF(payday)
	name = "Payday Subsystem"
	desc = "How people get paid."
	priority = SS_ORDER_LAST
	tick_rate = SECONDS_TO_TICKS(60)

	var/next_payday = -1
	var/stored_payday = 0

	tick_usage_max = 50


/subsystem/payday/unclog(var/mob/caller)
	tick_rate = -1
	. = ..()

/subsystem/payday/Initialize()
	next_payday = world.time + SECONDS_TO_DECISECONDS(180)
	return ..()

/subsystem/payday/on_life()

	if(next_payday > 0 && world.time >= next_payday)
		stored_payday *= 0.25 //Prevents gaming the system.
		trigger_payday()
		next_payday = world.time + SECONDS_TO_DECISECONDS(300)
		stored_payday = 0

	return TRUE

/subsystem/payday/proc/trigger_payday()

	var/list/valid_players = list()

	for(var/k in all_players)
		var/mob/living/advanced/player/P = k
		if(P.loyalty_tag != "NanoTrasen" || !P.client || P.dead || !P.allow_save)
			continue
		if(P.insurance_premiums > 0)
			var/tax = CEILING(P.currency * P.insurance_premiums,1)
			if(tax)
				var/charged_amount = -P.adjust_currency( -(tax + 50) )
				P.insurance += FLOOR(charged_amount*1,1)
				P.to_chat(span("notice","You were taxed your insurance premium of <b>[charged_amount] credits</b>. Your insurance pool is now <b>[P.insurance] credits</b>."))
				P.update_premiums()
		valid_players += P
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	if(length(valid_players))
		var/bonus_to_give = clamp(stored_payday/length(valid_players),0,5000)
		bonus_to_give = FLOOR(bonus_to_give,1)

		for(var/k in valid_players)
			var/mob/living/advanced/player/P = k
			var/job/J = JOB(P.job)
			if(!J)
				P.to_chat(span("payday","No job detected! Speak to the Head of Personnel on the Station to get a job!"))
				continue
			var/base_pay = J.passive_income + J.passive_income_bonus*(P.job_rank - 1)
			if(bonus_to_give)
				P.to_chat(span("payday","Hazard Pay! You have earned [base_pay] credits and a [bonus_to_give] credit bonus."))
			else
				P.to_chat(span("payday","Hazard Pay! You have earned [base_pay] credits for your efforts."))
			P.adjust_currency(bonus_to_give + base_pay)
			CHECK_TICK(tick_usage_max,FPS_SERVER)
