#define PRICE_MULTIPLIER_DIR "data/server/price_multipliers.txt"
#define GOLD_CIRCULATION_DIR "data/server/gold_circulation.txt"


SUBSYSTEM_DEF(economy)
	name = "Economy Subsystem"
	desc = "Handles economy saving/processing/ect."
	priority = SS_ORDER_PRELOAD

	var/credits_per_gold = 10 //This value is not saved.
	var/gold_in_circulation = 1000000
	var/list/price_multipliers = list() //Format: type (as text) : value
	var/list/purchases_this_round = list() //This is created by vendors. Not saved.

/subsystem/economy/Initialize()

	if(fexists(PRICE_MULTIPLIER_DIR))
		var/loaded_data = file2text(PRICE_MULTIPLIER_DIR)
		if(loaded_data)
			var/list/json_data = json_decode(loaded_data)
			if(length(json_data))
				price_multipliers = json_data
			else
				log_error("ERROR: No JSON data found in [PRICE_MULTIPLIER_DIR]!")
		else
			log_error("ERROR: No data found in [PRICE_MULTIPLIER_DIR]!")
	else
		log_error("ERROR: No file found in [PRICE_MULTIPLIER_DIR]!")


	if(fexists(GOLD_CIRCULATION_DIR))
		var/loaded_data = file2text(GOLD_CIRCULATION_DIR)
		if(loaded_data)
			loaded_data = text2num(loaded_data)
			if(loaded_data)
				gold_in_circulation = loaded_data
			else
				log_error("ERROR: No number data found in [GOLD_CIRCULATION_DIR]!")
		else
			log_error("ERROR: No valid data found in [GOLD_CIRCULATION_DIR]!")
	else
		log_error("ERROR: No file found in [GOLD_CIRCULATION_DIR]!")

	credits_per_gold = CEILING(1000000/gold_in_circulation,1)

	. = ..()

/subsystem/economy/proc/save(var/debug=FALSE)

	var/client_length = length(all_clients)

	gold_in_circulation -= CEILING(world.time/100,1)*client_length*0.5

	var/expected_purchases = (1*client_length)*(world.time/SECONDS_TO_DECISECONDS(30*60)) //Base 1 per player every 30 minutes
	for(var/item_type in purchases_this_round)
		var/old_multiplier = (price_multipliers[item_type] ? price_multipliers[item_type] : 1)
		var/local_expected_purchases = expected_purchases * old_multiplier
		var/actual_purchases = purchases_this_round[item_type]
		var/new_multiplier = (actual_purchases/local_expected_purchases) * old_multiplier
		price_multipliers[item_type] = clamp(new_multiplier,old_multiplier*0.9,old_multiplier*1.1) //Cannot change by 10% in a single round.
		if(debug) log_debug("Expected [local_expected_purchases] purchases this round of [item_type], got [actual_purchases]. New multiplier: [price_multipliers[item_type]].")


	if(length(price_multipliers))
		var/encoded_purchase_data = json_encode(price_multipliers)
		if(encoded_purchase_data)
			fdel(PRICE_MULTIPLIER_DIR)
			text2file(encoded_purchase_data,PRICE_MULTIPLIER_DIR)

	fdel(GOLD_CIRCULATION_DIR)
	text2file("[gold_in_circulation]",GOLD_CIRCULATION_DIR)

	return TRUE

