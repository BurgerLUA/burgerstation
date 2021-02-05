

SUBSYSTEM_DEF(projectiles)
	name = "Projectile Subsystem"
	desc = "Controls projectiles."
	tick_rate = PROJECTILE_TICK
	priority = SS_ORDER_IMPORTANT

	cpu_usage_max = 100
	tick_usage_max = 100

	use_time_dialation = FALSE

	var/list/obj/projectile/all_projectiles = list()

/subsystem/projectiles/unclog(var/mob/caller)

	for(var/k in all_projectiles)
		var/obj/projectile/P = k
		qdel(P) //Remove is called inside the projectile

	broadcast_to_clients(span("danger","Removed all projectiles."))

	return ..()

/subsystem/projectiles/on_life()

	for(var/k in all_projectiles)
		var/obj/projectile/P = k
		if(P.update_projectile(tick_rate) == null)
			log_error("Warning! Projectile [P.get_debug_name()] didn't run update_projectile properly, and thus was deleted.")
			qdel(P) //Remove is called inside the projectile

	return TRUE
