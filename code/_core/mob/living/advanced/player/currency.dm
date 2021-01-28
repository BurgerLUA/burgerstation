/mob/living/advanced/player/proc/adjust_currency(var/currency_to_add,var/tax=FALSE)
	if(!currency_to_add)
		return FALSE
	var/old_currency = currency
	currency = max(currency + currency_to_add,0)
	var/difference = currency - old_currency
	for(var/obj/hud/button/cash_money/B in src.buttons)
		B.update_stats(currency)

	if(!tax)
		if(difference > 0)
			revenue += difference
		else
			expenses += -difference

	return difference

/mob/living/advanced/player/proc/spend_currency(var/currency_to_spend)
	if(currency < currency_to_spend)
		return FALSE
	return -adjust_currency(-currency_to_spend)



/mob/living/advanced/player/proc/adjust_burgerbux(var/currency_to_add)
	if(!currency_to_add)
		return FALSE
	if(!client)
		return 0
	var/savedata/client/globals/globals = GLOBALDATA(client.ckey)
	var/old_currency = globals.loaded_data["burgerbux"]
	globals.loaded_data["burgerbux"] = max(globals.loaded_data["burgerbux"] + currency_to_add,0)
	var/difference = globals.loaded_data["burgerbux"] - old_currency
	for(var/obj/hud/button/microstransactions/B in src.buttons)
		B.update_stats(globals.loaded_data["burgerbux"])

	return difference

/mob/living/advanced/player/proc/spend_burgerbux(var/currency_to_spend)
	if(currency < currency_to_spend)
		return FALSE
	return -adjust_burgerbux(-currency_to_spend)