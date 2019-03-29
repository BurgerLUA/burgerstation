// https://www.desmos.com/calculator/lg5zticzca
/experience/
	var/name = "Base Experience Tracker"
	var/id
	var/desc = "This is the base experience tracker. You shouldn't have this."
	var/desc_extended = "Extended description for that wall of text."
	var/experience = 0

	var/chargen_min_level = 1
	var/chargen_max_level = 100
	var/default_level = 5
	var/counts_towards_level = TRUE

	var/last_level = 0

	var/experience_power = 2
	var/experience_multiplier = 30

	var/max_level = 100

	var/flags = 0

	var/mob/living/owner


	var/list/associated_classes = list()

/experience/New(var/mob/M)
	owner = M
	. = ..()

/experience/proc/Initialize(var/desired_xp)
	experience = desired_xp
	last_level = xp_to_level(desired_xp)

/experience/proc/xp_to_level(var/xp) //Convert xp to level
	return floor( (xp ** (1/experience_power) ) / experience_multiplier)

/experience/proc/level_to_xp(var/level) //Convert level to xp
	return ceiling( (level*experience_multiplier) ** experience_power)

/experience/proc/set_level(var/level)
	if(!ENABLE_XP)
		return FALSE
	experience = level_to_xp(clamp(level,1,max_level))

/experience/proc/get_current_level()
	return min(max_level,xp_to_level(experience))

/experience/proc/get_xp()
	return experience

/experience/proc/add_xp(var/xp_to_add)
	if(!ENABLE_XP)
		return FALSE
	experience += xp_to_add
	var/current_level = get_current_level()
	if(last_level != current_level)
		on_level_up(last_level,current_level)

/experience/proc/set_xp(var/new_xp)
	if(!ENABLE_XP)
		return FALSE
	experience = new_xp

/experience/proc/get_power(var/min=1,var/max=100)
	return scale(get_current_level(),min,max)

/experience/proc/on_level_up(var/old_level,var/new_level)
	owner.to_chat(span("notice","Your [name] increased to [new_level]."))
	last_level = new_level
	if(owner.update_level())
		owner.to_chat(span("notice","Your overall level increased to [owner.level]."))



