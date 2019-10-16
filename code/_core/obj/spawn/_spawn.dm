/obj/mob_spawn/
	name = "mob spawn"
	var/mob_type
	var/mob_stored
	var/time_to_respawn
	var/time_of_death
	var/level_multiplier
	invisibility = 101

/obj/mob_spawn/New(var/desired_location,var/desired_mob_type,var/desired_mob_stored,var/desired_time_to_respawn,var/desired_level_mulitplier)
	mob_type = desired_mob_type
	mob_stored = desired_mob_stored
	time_to_respawn = desired_time_to_respawn
	level_multiplier = desired_level_mulitplier
	return ..()
