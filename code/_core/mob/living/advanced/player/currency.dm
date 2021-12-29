/mob/living/advanced/player/proc/adjust_currency(var/currency_to_add,var/tax=FALSE)
	if(!currency_to_add)
		return FALSE
	var/old_currency = currency
	currency = clamp(currency + currency_to_add,0,999999999)
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
		return FALSE
	var/savedata/client/globals/GD = GLOBALDATA(client.ckey)
	if(!GD)
		return FALSE
	var/old_currency = GD.loaded_data["burgerbux"]
	GD.loaded_data["burgerbux"] = max(GD.loaded_data["burgerbux"] + currency_to_add,0)
	var/difference = GD.loaded_data["burgerbux"] - old_currency
	for(var/obj/hud/button/microstransactions/B in src.buttons)
		B.update_stats(GD.loaded_data["burgerbux"])

	return difference

/mob/living/advanced/player/proc/spend_burgerbux(var/currency_to_spend)
	if(currency < currency_to_spend)
		return FALSE
	return -adjust_burgerbux(-currency_to_spend)