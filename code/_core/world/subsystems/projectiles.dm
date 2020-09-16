var/global/list/obj/projectile/all_projectiles = list()

SUBSYSTEM_DEF(projectile)
	name = "Projectile Subsystem"
	desc = "Controls projectiles."
	tick_rate = PROJECTILE_TICK
	priority = SS_ORDER_IMPORTANT

	cpu_usage_max = 95
	tick_usage_max = 95

	use_time_dialation = FALSE

/subsystem/projectile/on_life()

	for(var/k in all_projectiles)
		var/obj/projectile/P = k
		CHECK_TICK(tick_usage_max,1)
		P.update_projectile(tick_rate)

	return TRUE
