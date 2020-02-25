var/global/list/obj/projectile/all_projectiles = list()

SUBSYSTEM_DEF(projectile)
	name = "Projectile Subsystem"
	desc = "Controls projectiles."
	tick_rate = PROJECTILE_TICK
	priority = SS_ORDER_IMPORTANT

/subsystem/projectile/on_life()

	for(var/obj/projectile/P in all_projectiles)
		P.update_projectile()

	return TRUE
