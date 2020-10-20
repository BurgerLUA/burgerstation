SUBSYSTEM_DEF(ghost)
	name = "Ghost Subsystem"
	desc = "Controls ghost related stuff."
	priority = SS_ORDER_LAST
	tick_rate = SECONDS_TO_TICKS(1)

	cpu_usage_max = 75
	tick_usage_max = 75

	var/list/obj/item/weapon/melee/tool/emf/all_emf_trackers = list()
	var/list/obj/emf/all_emfs = list()

/subsystem/ghost/on_life()

	for(var/k in all_emf_trackers)
		CHECK_TICK(cpu_usage_max,FPS_SERVER)
		var/obj/item/weapon/melee/tool/emf/E = k
		E.on_emf_think()

	return ..()