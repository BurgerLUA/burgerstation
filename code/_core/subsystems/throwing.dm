var/global/list/atom/movable/projectiles = list()

/datum/subsystem/projectile/
	name = "Projectile Subsystem"
	desc = "Controls objects that fly."
	tick_rate = 1
	priority = 98
	priority = SS_ORDER_THROWING

/datum/subsystem/projectile/on_life()
	for(var/atom/movable/P in projectiles)
		if(!step(P,P.dir,P.throw_speed))
			projectiles -= P

	return TRUE

/proc/add_projectile(var/atom/movable/P)
	projectiles += P

