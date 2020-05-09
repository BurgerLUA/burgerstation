client/verb/get_threat_level()
	set name = "Get Threat Level"
	set category = "Debug"

	mob.to_chat("The threat level is: [SShorde.get_threat_level()].")


client/verb/get_enemies_to_spawn()
	set name = "Get Enemies to Spawn"
	set category = "Debug"

	var/desired_enemies = SShorde.get_enemies_to_spawn()
	var/tracked_enemy_count = length(SShorde.tracked_enemies)

	mob.to_chat("There are currently [tracked_enemy_count] enemies. The game wants to spawn [desired_enemies] more.")