var/global/list/all_wishgranters = list()

/subsystem/wishgranter/
	name = "Wishgranter Subsystem"
	desc = "Yes."
	priority = SS_ORDER_NORMAL

/subsystem/wishgranter/Initialize()
	for(var/obj/structure/interactive/wishgranter/normal/W in world)
		all_wishgranters[W.id] = W

	LOG_SERVER("Initialized [length(all_prefixes)] wishgranters.")