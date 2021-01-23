var/global/list/obj/marker/backup_spawn/backup_spawnpoints = list()

/obj/marker/backup_spawn
	name = "backup spawnpoint"

/obj/marker/backup_spawn/New(var/desired_loc)
	backup_spawnpoints |= src
	return ..()
