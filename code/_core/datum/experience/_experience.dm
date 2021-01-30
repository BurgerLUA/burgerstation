// https://www.desmos.com/calculator/lg5zticzca
/experience/
	var/name = "Base Experience Tracker"
	var/id = null
	var/desc = "This is the base experience tracker. You shouldn't have this."
	var/desc_extended = "Extended description for that wall of text."

	var/experience = 0

	var/chargen_min_level = 1
	var/chargen_max_level = 100
	var/default_level = 5
	var/counts_towards_level = TRUE

	var/combat_level_mul = 0 //How much this skill counts towards your combat level.

	var/last_level = 0

	var/experience_power = 2
	var/experience_multiplier = 30

	var/flags = 0

	var/mob/living/owner

/experience/get_examine_list(var/mob/examiner)
	return list(div("examine_title","[name]"),div("examine_description","[desc]"),div("examine_description","[desc]"),div("examine_description_long",src.desc_extended))

/experience/Destroy()
	owner = null
	return ..()

/experience/New(var/mob/M)
	owner = M
	return ..()

/experience/proc/update_experience(var/desired_xp)
	desired_xp = max(0,desired_xp)
	experience = desired_xp
	last_level = min(xp_to_level(experience),100)
	return TRUE

/experience/proc/xp_to_level(var/xp) //Convert xp to level
	if(xp < 0)
		owner.to_chat(span("danger","Your [src.name] experience is negative! Report this bug on discord!"))
		return 1
	return FLOOR((xp ** (1/experience_power)) / experience_multiplier, 1)

/experience/proc/level_to_xp(var/level) //Convert level to xp
	if(level < 0)
		owner.to_chat(span("danger","Your [src.name] level is negative! Report this bug on discord!"))
		return 0
	return CEILING((level*experience_multiplier) ** experience_power,1)

/experience/proc/set_level(var/level)
	if(!ENABLE_XP)
		return FALSE
	experience = level_to_xp(clamp(level,1,owner.max_level))
	return experience

/experience/proc/get_current_level()
	return min(owner.max_level,xp_to_level(experience))

/experience/proc/get_xp()
	return experience

/experience/proc/add_xp(var/xp_to_add,var/bypass_checks = FALSE)

	if(!(bypass_checks || owner.allow_experience_gains))
		return FALSE

	if(!ENABLE_XP)
		return FALSE

	experience += xp_to_add

	var/current_level = get_current_level()
	if(last_level != current_level)
		on_level_up(last_level,current_level)

	last_level = current_level //Just in case it's leveled down or something.

	owner.on_add_xp(src,xp_to_add)

	return xp_to_add

/experience/proc/set_xp(var/new_xp)
	if(!ENABLE_XP)
		return FALSE
	experience = new_xp
	return experience

/experience/proc/get_power(var/min_power = 0.25,var/max_power = 1)
	return clamp(last_level / 100,min_power,max_power)

/experience/proc/on_level_up(var/old_level,var/new_level)
	owner.on_level_up(src,old_level,new_level)
	return new_level



