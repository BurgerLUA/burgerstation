/obj/marker/mob_spawn/
	name = "Mob Spawnpoint"
	desc = "This is where a mob should be placed at round start."

	icon = 'icons/lighting.dmi'
	icon_state = "white"

	var/type_to_spawn
	var/time_to_respawn = 0 //Set to 0 if it doesn't respawn. Measured in deciseconds

	//Internal Values
	var/mob/living/owning_mob
	var/death_time = 0

	var/random_dir = FALSE

	var/level_multiplier = 1 //The level multiplier of this spawn. Keep in mind that the area also multiplies the mobs level.

/obj/marker/mob_spawn/New(var/desired_loc)
	..()
	mob_spawnpoints += src

/obj/marker/mob_spawn/proc/attempt_spawn()

	if(!type_to_spawn)
		return

	if(owning_mob)
		if(!time_to_respawn)
			return
		if(!death_time && (owning_mob.status & FLAG_STATUS_DEAD))
			death_time = curtime
			return
		if(death_time && death_time + time_to_respawn > curtime)
			return

	var/area/A = get_area(src)

	owning_mob = new type_to_spawn(src.loc,desired_level_multiplier = level_multiplier * A.level_multiplier)
	if(random_dir)
		owning_mob.dir = pick(NORTH,EAST,SOUTH,WEST)
	else
		owning_mob.dir = dir

	death_time = 0