/disease/
	var/name = "Disease name"
	var/desc = "Disease desc."

	var/stage = 0
	var/stage_max = 4
	var/stage_per_minute = 1 //At normal conditions (immune system being 100)

	var/immune_system_mod = 10 //This value times stage is added to the owner's immune system.
	var/immune_system_mod_starts_at_stage = 2 //Stage at which the immune system mod should kick in.

/disease/proc/on_add(var/mob/living/owner)
	return TRUE

/disease/proc/on_remove(var/mob/living/owner)
	return TRUE

/disease/proc/on_life(var/mob/living/owner)
	var/mul = (2 - owner.immune_system_strength/100)
	var/stage_to_add = TICKS_TO_SECONDS(LIFE_TICK_SLOW)/(stage_per_minute*60)
	stage = clamp(stage+(stage_to_add*mul),0,stage_max)
	return TRUE

/disease/cave_rot_fever
	name = "Cave Rot Fever"
	desc = "A common disease usually found in cave enviroments  Symptoms include lethargy and reduced appetite."

/disease/hrp
	name = "High Retinal Pneumonia"
	desc = "An uncommon disease found in colonies with beds. \
	Symptoms include lethargy, trouble breathing and erratic eye movements."
	var/inhale_switch = FALSE

/disease/hrp/on_life(var/mob/living/owner)
	. = ..()
	if(prob(stage*25))
		if(stage >= 1 && prob(40))
			owner.do_emote("blink")
		else if(stage >= 2)
			if(inhale_switch)
				owner.do_emote("inhale")
			else
				owner.do_emote("exhale")
			inhale_switch = !inhale_switch