/experience/
	var/name = "Base Experience Tracker"
	var/id
	var/desc = "This is the base experience tracker. You shouldn't have this."
	var/desc_extended = "Extended description for that wall of text."
	var/experience = 0

	var/experience_power = 2
	var/experience_multiplier = 30

	var/max_level = 100

	var/flags = 0

	var/mob/owner

/experience/New(var/mob/M)
	owner = M
	. = ..()

/experience/proc/xp_to_level(var/xp) //Convert xp to level
	return floor( (xp ** (1/experience_power) ) / experience_multiplier)

/experience/proc/level_to_xp(var/level) //Convert level to xp
	return ceiling( (level*experience_multiplier) ** experience_power)

/experience/proc/set_level(var/level)
	experience = level_to_xp(level)

/experience/proc/get_current_level()
	return min(max_level,xp_to_level(experience))

/experience/proc/get_current_xp()
	return experience

/experience/proc/get_power(var/min=1,var/max=100)
	return scale(get_current_level(),min,max)