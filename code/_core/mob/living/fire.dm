#define MAX_FIRE_STACKS 300
#define MIN_FIRE_STACKS -300

/mob/living/proc/adjust_fire_stacks(var/added_fire_stacks = 10)
	if(!added_fire_stacks)
		return FALSE
	fire_stacks = clamp(fire_stacks + added_fire_stacks,MIN_FIRE_STACKS,MAX_FIRE_STACKS)
	fire_stacks_max = max(fire_stacks_max,fire_stacks) //Not actually the maximum fire stacks but rather something cosmetic for the resist bar.
	resist_percent = clamp(fire_stacks/fire_stacks_max,0,1)
	if(!next_resist)
		next_resist = 1
	if(fire_stacks <= 0)
		extinguish()
	else if(on_fire)
		if(!fire_overlay)
			CRASH("Warning: [src.get_debug_name()] did not have a fire overlay!")
		else
			fire_overlay.icon_state = "[clamp(FLOOR(1 + (fire_stacks/MAX_FIRE_STACKS)*3,1),1,3)]"

	stat_elements_to_update |= stat_elements["resist"]

	return TRUE

/mob/living/proc/ignite(var/added_fire_stacks = 0,var/atom/source)

	if(on_fire)
		if(added_fire_stacks) adjust_fire_stacks(added_fire_stacks)
		return FALSE

	if(added_fire_stacks) adjust_fire_stacks(added_fire_stacks)

	if(fire_stacks <= 0)
		return FALSE

	if(ai)
		ai.on_damage_received(null,source,null,null,null,added_fire_stacks*5,null,FALSE)

	on_fire = TRUE
	play_sound('sound/weapons/magic/fireball.ogg',get_turf(src),range_max=VIEW_RANGE,volume = 25)

	return TRUE

/mob/living/proc/extinguish()

	if(!on_fire)
		return FALSE

	on_fire = FALSE
	fire_stacks_max = 0
	next_resist = 0
	resist_percent = 0

	if(!fire_overlay)
		CRASH("Warning: [src.get_debug_name()] did not have a fire overlay!")
	else
		fire_overlay.icon_state = "0"

	stat_elements_to_update |= stat_elements["resist"]

	return TRUE