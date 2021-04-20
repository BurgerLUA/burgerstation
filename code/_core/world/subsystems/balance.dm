SUBSYSTEM_DEF(balance) //Finally. A subsystem dedicated to BALLS.
	name = "Balance Subsystem"
	desc = "Makes a report of weapons."
	priority = SS_ORDER_REPORT

/subsystem/balance/Initialize()

	var/list/stored_dps = list()

	for(var/k in subtypesof(/obj/item/weapon/))
		var/obj/item/weapon/W = new k
		stored_dps[W.type] = W.get_dps()
		qdel(W)


