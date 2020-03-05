/mob/living/proc/on_staggered()
	src.visible_message("\The [src.name] reels backwards!","You reel backwards from the staggering impact!")
	return TRUE

/mob/living/proc/on_unstaggered()
	return TRUE

/mob/living/proc/on_rest()
	return TRUE

/mob/living/proc/on_unrest()
	return TRUE

/mob/living/proc/on_stunned()
	src.visible_message("\The [src.name] gets knocked down!","You get knocked down! You're stunned!")
	return TRUE

/mob/living/proc/on_unstunned()
	src.visible_message("\The [src.name] gets back up!","You force yourself on your feet!")
	return TRUE

/mob/living/proc/on_paralyzed()
	src.visible_message("\The [src.name] freezes up and collapses!","You can't move your limbs! You're paralyzed!")
	return TRUE

/mob/living/proc/on_unparalyzed()
	src.visible_message("\The [src.name] unfreezes!","You regain control of your limbs!")
	return TRUE

/mob/living/proc/on_confused()
	src.visible_message("\The [src.name] looks confused!","You can't think straight!")
	return TRUE

/mob/living/proc/on_unconfused()
	src.visible_message("\The [src.name] snaps out of it!","You snap out of it!")
	return TRUE

/mob/living/proc/on_fatigued()
	src.visible_message("\The [src.name] collapses!","You collapse from exhaustion! You're fatigued!")
	return TRUE

/mob/living/proc/on_unfatigued()
	if(health)
		health.stamina_current = health.stamina_max
	src.visible_message(span("warning","\The [src.name] wakes up!","You wake up feeling [health && health.health_current < health.health_max ? "refreshed... sort of." : "refreshed!"]"))
	return TRUE

/mob/living/proc/on_adrenaline()
	src.to_chat("You feel a rush of energy!")
	spawn while(status & FLAG_STATUS_ADRENALINE)
		animate(src,pixel_x = rand(-1,1),pixel_y = rand(-1,1),time = 1)
		sleep(1)
	return TRUE

/mob/living/proc/on_unadrenaline()
	src.to_chat("The rush of energy disappears.")
	animate(src,pixel_x = 0,pixel_y = 0,time = 1)
	return TRUE

/mob/living/proc/on_sleeped()
	//src.visible_message("\The [src.name] lies down for a nap...","You lie down for a nap...")
	return TRUE

/mob/living/proc/on_unsleeped()
	//src.visible_message(span("warning","\The [src.name] wakes up from their slumber","You wake up from your slumber."))
	return TRUE

/mob/living/proc/on_crit()
	src.visible_message("\The [src.name] falls unconscious!","You lose consciousness!")
	return TRUE

/mob/living/proc/on_uncrit()
	src.visible_message("\The [src.name] regains consciousness!","You gain consciousness!")
	return TRUE