/ai/boss/ai_core






/ai/boss/ai_core/handle_attacking()

	//Spawn cyborg spawners.
	var/mob/living/simple/silicon/ai/A = owner
	if(A.next_spawner_spawn <= world.time)
		A.spawn_spawners()

	return TRUE