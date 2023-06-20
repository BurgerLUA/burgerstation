

SUBSYSTEM_DEF(projectiles)
	name = "Projectile Subsystem"
	desc = "Controls projectiles."
	tick_rate = PROJECTILE_TICK
	priority = SS_ORDER_IMPORTANT

	tick_usage_max = 100

	use_time_dialation = FALSE

	var/list/obj/projectile/all_projectiles = list()

/subsystem/projectiles/unclog(var/mob/caller)

	for(var/k in all_projectiles)
		var/obj/projectile/P = k
		all_projectiles -= k
		if(!P || P.qdeleting)
			continue
		qdel(P)

	return ..()

/subsystem/projectiles/on_life()

	for(var/k in all_projectiles)
		var/obj/projectile/P = k
		var/result = P.update_projectile(tick_rate)
		if(result)
			CHECK_TICK(tick_usage_max,FPS_SERVER)
			continue
		if(result == null)
			log_error("Warning! Projectile [P.get_debug_name()] didn't run update_projectile properly, and thus was deleted.")
		qdel(P) //Remove is called inside the projectile
		CHECK_TICK(tick_usage_max,FPS_SERVER)

	return TRUE
