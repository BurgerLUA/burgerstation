var/global/list/obj/structure/interactive/shop/all_shops = list()

SUBSYSTEM_DEF(shop)
	name = "Shop Subsystem"
	desc = "Controls shops."
	tick_rate = SECONDS_TO_TICKS(1)
	priority = SS_ORDER_NORMAL

	var/countdown = SHOP_RESTOCK_COUNTDOWN

/subsystem/shop/Initialize()

	var/total_items = 0

	for(var/obj/structure/interactive/shop/S in world)

		if(!S.Initialize())
			continue

		all_shops += S
		total_items += length(S.stored_items)

	LOG_SERVER("Initialized [length(all_shops)] shops with [length(total_items)].")

	restock()

/subsystem/shop/on_life()

	countdown -= 1

	if(countdown <= 0)
		restock()
		countdown = initial(countdown)

	return TRUE

/subsystem/shop/proc/restock()

	for(var/obj/structure/interactive/shop/S in all_shops)
		S.restock()

	return TRUE
