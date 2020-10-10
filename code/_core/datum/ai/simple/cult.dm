/ai/cultist/

/ai/behemoth/

/ai/artificer/
	var/list/mob/living/tracked_mobs = list()

/ai/artificer/handle_attacking()

	if(objective_attack && length(tracked_mobs) < 4 && owner.health && owner.health.mana_current >= 20)
		owner.health.adjust_mana(-20)
		var/mob/living/simple/npc/cult/construct/harvester/H = new(owner.loc)
		INITIALIZE(H)
		GENERATE(H)
		FINALIZE(H)
		tracked_mobs += H
		HOOK_ADD("post_death","artificer_post_death",H,src,.proc/remove_tracked_mob)

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