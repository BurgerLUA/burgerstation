/loot/currency
	var/desired_value = 1000 //How much (on average) do we want to give to the player (if possible).
	loot_count = 1

/loot/currency/pre_spawn(var/atom/movable/M)
	. = ..()
	// https://www.desmos.com/calculator/o2npnuupqr
	if(istype(M,/obj/item/))
		var/obj/item/I = M
		var/value = I.get_base_value()
		if(value <= 0)
			value = 1
		var/rng_result = rand()**(value/desired_value)
		I.amount =  FLOOR(I.amount*rng_result,1)
		if(I.amount < 1)
			I.amount = 1


/loot/currency/dosh
	loot_table_guaranteed = /obj/item/currency/dosh

/loot/currency/credits
	loot_table_guaranteed = /obj/item/currency/credits

/loot/currency/gold_coin
	loot_table_guaranteed = /obj/item/currency/gold_coin




