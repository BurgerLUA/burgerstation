var/global/list/obj/projectile/all_projectiles = list()

/datum/subsystem/projectile/
	name = "Projectile Subsystem"
	desc = "Controls projectiles."
	tick_rate = 3
	priority = 98
	priority = SS_ORDER_THROWING

/datum/subsystem/projectile/on_life()
	for(var/obj/projectile/P in all_projectiles)
		P.update_projectile()

	return TRUE
