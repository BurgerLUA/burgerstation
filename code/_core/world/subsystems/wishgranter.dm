var/list/obj/structure/interactive/localmachine/snowflake/wishgranter/all_wishgranters = list()

SUBSYSTEM_DEF(wishgranter)
	name = "Wishgranter Subsystem"
	desc = "Yes."
	priority = SS_ORDER_NORMAL

/subsystem/wishgranter/Initialize()

	for(var/obj/structure/interactive/localmachine/snowflake/wishgranter/W in world)
		var/area/A = get_area(W)
		if(A && A.assoc_wishgranter)
			W.id = A.assoc_wishgranter
			all_wishgranters[W.id] = W
		else
			LOG_ERROR("WARNING: Wishgranter at [W.x],[W.y] has a bad area!")

	LOG_SERVER("Initialized [length(all_prefixes)] wishgranters.")