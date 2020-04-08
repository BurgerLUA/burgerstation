/mob/living/advanced/player/proc/adjust_currency(var/currency_to_add)

	if(!currency_to_add)
		return FALSE

	var/old_currency = currency
	currency = clamp(currency + currency_to_add,0,99999)
	var/difference = currency - old_currency

	for(var/obj/hud/button/cash_money/B in src.buttons)
		B.update_stats(currency)

	return difference

/mob/living/advanced/player/proc/spend_currency(var/currency_to_spend)

	if(currency < currency_to_spend)
		return FALSE

	return -adjust_currency(-currency_to_spend)


/mob/living/advanced/player/verb/give_dosh(var/dosh_amount as num)
	set category = "Fun"
	set name = "Give Dosh"
	var/added_currency = src.adjust_currency(dosh_amount)
	src.to_chat("You gave yourself [added_currency] credits.")