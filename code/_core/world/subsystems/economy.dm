#define PRICE_MULTIPLIER_DIR "data/server/price_multipliers.txt"
#define GOLD_CIRCULATION_DIR "data/server/gold_circulation.txt"
#define GOBLIN_CIRCULATION_DIR "data/server/gold_circulation_goblin.txt"


SUBSYSTEM_DEF(economy)
	name = "Economy Subsystem"
	desc = "Handles economy saving/processing/ect."
	priority = SS_ORDER_CONFIG

	var/credits_per_gold = 10 //This value is not saved.
	var/gold_in_circulation = 1000000
	var/list/price_multipliers = list() //Format: type (as text) : value
	var/list/purchases_this_round = list() //This is created by vendors. Not saved.
	var/gold_base_value = 5000000 //How much credits are invested into gold.

	var/goblin_economy = 75000 //How much gold goblins have.
	var/sell_multiplier = 1
	var/crash_sell_multiplier = 1

/subsystem/economy/proc/update_stats()
	if(gold_in_circulation < 0)
		gold_in_circulation = FLOOR(initial(gold_base_value)*RAND_PRECISE(0.5,1),1)
		announce(
			"Central Command Economic Division",
			"Gold Market Crash",
			"Central Command Economic Division regrets to inform all employees that gold has suffered a mysterious economic crash. We apologize for the inconvience.",
			sound_to_play = 'sound/round_end/dump_it.ogg'
		)
		crash_sell_multiplier = 0.1
	if(goblin_economy < 0)
		goblin_economy = initial(goblin_economy)
		announce(
			"Central Command Economic Division",
			"Goblin Market Crash",
			"Central Command Economic Division regrets to inform all employees that the Goblin Economy has suffered a mysterious economic crash. We apologize for the inconvience.",
			sound_to_play = 'sound/round_end/dump_it.ogg'
		)
		crash_sell_multiplier = 0.1

	credits_per_gold = min(1 + max(0,CEILING(gold_base_value/gold_in_circulation,1)),15)
	sell_multiplier = clamp(goblin_economy/50000,0.1,1)*0.5

	if(gold_in_circulation <= 20000) //About to crash.
		credits_per_gold = FLOOR(credits_per_gold*RAND_PRECISE(0.5,2),1)
		sell_multiplier *= 0.5

/subsystem/economy/Initialize()

	if(fexists(PRICE_MULTIPLIER_DIR))
		var/loaded_data = rustg_file_read(PRICE_MULTIPLIER_DIR)
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
		var/loaded_data = rustg_file_read(GOLD_CIRCULATION_DIR)
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

	if(fexists(GOBLIN_CIRCULATION_DIR))
		var/loaded_data = rustg_file_read(GOBLIN_CIRCULATION_DIR)
		if(loaded_data)
			loaded_data = text2num(loaded_data)
			if(loaded_data)
				goblin_economy = loaded_data
			else
				log_error("ERROR: No number data found in [GOBLIN_CIRCULATION_DIR]!")
		else
			log_error("ERROR: No valid data found in [GOBLIN_CIRCULATION_DIR]!")
	else
		log_error("ERROR: No file found in [GOBLIN_CIRCULATION_DIR]!")

	update_stats()

	. = ..()

/subsystem/economy/proc/save()

	var/client_length = length(all_clients)

	gold_in_circulation -= CEILING(world.time/100,1)*client_length*0.5

	var/expected_purchases = (1*client_length)*(world.time/SECONDS_TO_DECISECONDS(90*60)) //Base 1 per player every 90 minutes
	for(var/item_type in purchases_this_round)
		var/old_multiplier = (price_multipliers[item_type] ? price_multipliers[item_type] : 1)
		var/local_expected_purchases = expected_purchases * old_multiplier
		var/actual_purchases = purchases_this_round[item_type]
		var/new_multiplier = (actual_purchases/local_expected_purchases) * old_multiplier
		price_multipliers[item_type] = clamp(new_multiplier,old_multiplier*0.9,old_multiplier*1.1) //Cannot change by 10% in a single round.

	if(length(price_multipliers))
		var/encoded_purchase_data = json_encode(price_multipliers)
		if(encoded_purchase_data)
			fdel(PRICE_MULTIPLIER_DIR)
			text2file(encoded_purchase_data,PRICE_MULTIPLIER_DIR)

	fdel(GOLD_CIRCULATION_DIR)
	text2file("[gold_in_circulation]",GOLD_CIRCULATION_DIR)

	fdel(GOBLIN_CIRCULATION_DIR)
	text2file("[goblin_economy]",GOBLIN_CIRCULATION_DIR)

	return TRUE

