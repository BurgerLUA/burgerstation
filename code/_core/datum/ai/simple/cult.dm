/ai/cultist/

/ai/behemoth/

/ai/artificer/
	var/list/mob/living/tracked_mobs = list()
	var/next_spawn = 0

/ai/artificer/handle_attacking()

	if(objective_attack && length(tracked_mobs) < 4 && owner.health && owner.health.mana_current >= 20 && next_spawn <= world.time)
		owner.health.adjust_mana(-20)
		var/mob/living/simple/cult/construct/harvester/H = new(owner.loc)
		INITIALIZE(H)
		GENERATE(H)
		FINALIZE(H)
		tracked_mobs += H
		HOOK_ADD("post_death","artificer_post_death",H,src,.proc/remove_tracked_mob)
		next_spawn = world.time + SECONDS_TO_DECISECONDS(3)

	return ..()

/ai/artificer/proc/remove_tracked_mob(var/mob/living/L,var/args)
	tracked_mobs -= L


/ai/artificer/handle_movement()

	if(objective_attack && length(tracked_mobs) < 4 && owner.health && owner.health.mana_current >= 20)
		owner.move_dir = 0x0
		return TRUE

	return ..()

/ai/harvester/


/ai/chosen

/ai/construct