SUBSYSTEM_DEF(shop)
	name = "Shop Subsystem"
	desc = "Controls shops."
	priority = SS_ORDER_OBJS_POST

/subsystem/shop/Initialize()

	var/total_shops = 0

	for(var/obj/structure/interactive/shop/S in world)
		S.initialize_shop()
		total_shops++

	log_subsystem(name,"Initialized [length(total_shops)] shops.")