SUBSYSTEM_DEF(explosion)
	name = "Explosion Subsystem"
	desc = "Processes explosions."
	priority = SS_ORDER_NORMAL
	tick_rate = DECISECONDS_TO_TICKS(1)

	var/list/obj/explosion_process/active_explosions = list()

	var/list/atom/damage_to_process = list()

	tick_usage_max = 75

	var/explosion_ticks = 0

/subsystem/explosion/proc/add_data(target,owner,source,epicenter,power,loyalty_tag)
	if(!damage_to_process[target])
		damage_to_process[target] = list()

	if(damage_to_process[target][owner])
		damage_to_process[target][owner]["power"] += power
	else
		damage_to_process[target][owner] = list()
		damage_to_process[target][owner]["source"] = source
		damage_to_process[target][owner]["epicenter"] = epicenter
		damage_to_process[target][owner]["magnitude"] = power
		damage_to_process[target][owner]["loyalty_tag"] = loyalty_tag

/subsystem/explosion/on_life()

	explosion_ticks++
	if(explosion_ticks >= 4)
		for(var/k in damage_to_process)
			var/atom/victim = k
			if(!victim || victim.qdeleting)
				damage_to_process -= k
				continue
			var/list/explosion_data = damage_to_process[k]
			for(var/j in explosion_data)
				CHECK_TICK(tick_usage_max,FPS_SERVER)
				var/atom/owner = j
				var/list/explosion_subdata = explosion_data[j]
				victim.act_explode(owner,explosion_subdata["source"],explosion_subdata["epicenter"],explosion_subdata["magnitude"],explosion_subdata["loyalty_tag"])
				explosion_data -= j
			if(!length(explosion_data))
				damage_to_process -= k
		explosion_ticks = 0

	for(var/k in active_explosions)
		CHECK_TICK(tick_usage_max,FPS_SERVER)
		var/obj/explosion_process/EP = k
		EP.process()

	return TRUE
