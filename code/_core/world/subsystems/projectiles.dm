var/global/list/obj/projectile/all_projectiles = list()

/subsystem/projectile/
	name = "Projectile Subsystem"
	desc = "Controls projectiles."
	tick_rate = DECISECONDS_TO_TICKS(0.5)
	priority = SS_ORDER_IMPORTANT

/subsystem/projectile/on_life()
	for(var/obj/projectile/P in all_projectiles)
		P.update_projectile()

	return TRUE
