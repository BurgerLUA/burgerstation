/loot/currency
	var/desired_value = 1000 //How much (on average) do we want to give to the player (if possible). This is per item.
	loot_count = 1

/loot/currency/pre_spawn(var/atom/movable/M)
	. = ..()
	if(desired_value > 0 && istype(M,/obj/item/))
		var/obj/item/I = M
		if(I.amount_max > 1)
			var/value_to_create = rand(0,desired_value*2)
			var/base_value = I.get_base_value()
			I.amount = value_to_create / base_value
			I.amount = FLOOR(I.amount,1)
			if(I.amount < 1)
				I.amount = 1
			if(I.amount > I.amount_max)
				I.amount = I.amount_max


/loot/currency/dosh
	loot_table_guaranteed = list(/obj/item/currency/dosh)

/loot/currency/dosh/survivor
	desired_value = 100

/loot/currency/credits
	loot_table_guaranteed = list(/obj/item/currency/credits)

/loot/currency/gold_coin
	loot_table_guaranteed = list(/obj/item/currency/gold_coin)

/loot/currency/cash_register
	loot_table = list(
		/obj/item/coin/cursed = 1,
		/obj/item/currency/gold_coin = 5,
		/obj/item/currency/credits = 20,
		/obj/item/currency/dosh = 200
	)
	chance_none = 25
	loot_count = 6
	desired_value = 300 //on average, per

/loot/currency/pocket_change
	loot_table = list(
		/obj/item/coin/cursed = 1,
		/obj/item/currency/gold_coin = 5,
		/obj/item/currency/credits = 20,
		/obj/item/currency/dosh = 200
	)
	loot_count = 1
	desired_value = 100 //on average, per

/loot/currency/telecrystals
	desired_value = 2500
	loot_table_guaranteed = list(/obj/item/currency/telecrystals)

/loot/currency/gold_bar
	desired_value = 5000
	loot_table_guaranteed = list(/obj/item/currency/gold_bar)

/loot/currency/telecrystals/small
	desired_value = 100

/loot/currency/magic_token
	desired_value = 1000
	loot_table_guaranteed = list(/obj/item/currency/magic_token)
