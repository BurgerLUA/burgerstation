/obj/structure/interactive/vending/contract
	name = "contract"
	markup = 2
	stored_types = list()


/obj/structure/interactive/vending/contract/New(var/desired_loc)

	var/list/possible_contracts = subtypesof(/obj/item/contract)
	for(var/k in possible_contracts) //First pass
		var/obj/item/contract/C = k
		if(initial(C.amount_max))
			continue
		possible_contracts -= k

	var/list/name_blacklist = list()

	for(var/i=1,i<=8*2,i++)
		if(!length(possible_contracts))
			break
		var/obj/item/contract/C = pick(possible_contracts)
		var/initial_name = initial(C.name)
		possible_contracts -= C
		if(name_blacklist[initial_name])
			continue
		name_blacklist[initial_name] = TRUE
		stored_types += C

	. = ..()


/obj/structure/interactive/vending/contract/get_bullshit_price(var/desired_price)
	return CEILING(desired_price,10)