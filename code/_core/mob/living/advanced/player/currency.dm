/mob/living/advanced/player/proc/adjust_currency(var/currency_to_add)

	if(!currency_to_add)
		return FALSE

	var/old_currency = currency
	currency = max(0,currency + currency_to_add)
	var/difference = currency - old_currency

	for(var/obj/hud/button/cash_money/B in src.buttons)
		B.update_stats(currency)

	return difference

/mob/living/advanced/player/proc/spend_currency(var/currency_to_spend)

	if(currency < currency_to_spend)
		return FALSE

	return -adjust_currency(-currency_to_spend)
