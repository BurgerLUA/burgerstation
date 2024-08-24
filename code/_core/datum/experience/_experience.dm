// https://www.desmos.com/calculator/lg5zticzca
/experience/
	var/name = "Base Experience Tracker"
	var/id = null
	var/desc = "This is the base experience tracker. You shouldn't have this."
	var/desc_extended = "Extended description for that wall of text."

	/// If your survival skill is lower than this value, you will see a vague description instead of a normal extended description
	var/skill_for_examine = 0
	var/desc_vague = "Affects... something"
	/// If you want, you can also optionally add in tips that show up at different levels of survival by making skill_for_examine into a list
	var/list/tips = list()

	var/experience = 0

	var/chargen_min_level = 1
	var/chargen_max_level = 100
	var/default_level = 0
	var/counts_towards_level = TRUE

	var/last_level = 0

	var/experience_power = 2
	var/experience_multiplier = 30

	var/flags = 0

	var/mob/living/owner

/experience/get_examine_list(var/mob/living/examiner)
	var/examine_level = istype(examiner) ? examiner.get_skill_level(SKILL_SURVIVAL) : 1
	var/list/completed_list = list(div("examine_title","[name]"),div("examine_description","[desc]"),div("examine_description","[desc]"),)
	if(!islist(skill_for_examine))
		var/more_xp_text = span("notice", "\n... you feel as if raising your survival skill would greatly help with evaluating this skill")
		completed_list += div("examine_description_long", examine_level >= skill_for_examine ? src.desc_extended : "[src.desc_vague]\n[more_xp_text]")
		return completed_list

	var/list/examine_list = skill_for_examine
	completed_list += "<div class='examine_description_long'>[examine_level >= examine_list[1] ? src.desc_extended : src.desc_vague]"
	var/current_tip = 1
	for(var/i in 1 to length(tips))
		if(examine_level >= examine_list[current_tip + 1])
			completed_list[4] += span("notice", "\n[tips[current_tip]]")
		current_tip++

	if(examine_level < examine_list[length(examine_list)])
		completed_list[4] += span("notice", "\n... you feel as if raising your survival skill would greatly help with evaluating this skill")

	completed_list[4] += "</div>"
	return completed_list

/experience/Destroy()
	owner = null
	return ..()

/experience/New(var/mob/M)
	if(!default_level)
		default_level = CONFIG("CHARGEN_DEFAULT_LEVEL",1)
	owner = M
	return ..()

/experience/proc/update_experience(var/desired_xp)
	desired_xp = max(0,desired_xp)
	experience = desired_xp
	last_level = min(xp_to_level(experience),get_max_level())
	return TRUE

/experience/proc/xp_to_level(var/xp) //Convert xp to level
	if(xp < 0)
		owner.to_chat(span("danger","Your [src.name] level is negative! Report this bug on discord!"))
		log_error("Warning: [src.name] xp was negative for [owner.get_debug_name()].")
		return 1
	return FLOOR((xp ** (1/experience_power)) / (experience_multiplier * (1 + src.get_prestige_count()*0.1)), 1)

/experience/proc/level_to_xp(var/level) //Convert level to xp
	if(level < 0)
		owner.to_chat(span("danger","Your [src.name] level is negative! Report this bug on discord!"))
		log_error("Warning: [src.name] xp was negative for [owner.get_debug_name()].")
		return 0
	return CEILING((level*experience_multiplier*(1 + src.get_prestige_count()*0.1)) ** experience_power,1)

/experience/proc/set_level(var/level)
	if(!ENABLE_XP)
		return FALSE
	experience = level_to_xp(clamp(level,1,get_max_level()))
	last_level = get_current_level()
	return experience

/experience/proc/get_current_level()
	return min(get_max_level(),xp_to_level(experience))

/experience/proc/get_xp()
	return experience

/experience/proc/add_xp(var/xp_to_add,var/bypass_checks = FALSE,var/difficulty_multiplier=TRUE)

	if(!ENABLE_XP)
		return FALSE

	if(!bypass_checks)
		if(!owner.allow_experience_gains)
			return FALSE
		if(owner.dead)
			return FALSE

	if(difficulty_multiplier && xp_to_add > 0 && !(flags & ATTRIBUTE_NO_DIFFICULTY_XP_MUL) && is_player(owner))
		var/mob/living/advanced/player/P = owner
		xp_to_add *= SSbalance.difficulty_to_xp_mod[P.get_difficulty()]

	experience = max(0,experience+xp_to_add)
	experience = CEILING(experience,1)

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

// https://www.desmos.com/calculator/bwdfwyg3ae
/experience/proc/get_power(var/min_power = 0.25,var/max_power = 1,var/absolute_max_power,var/bonus_level=0)
	if(!absolute_max_power)
		absolute_max_power = max_power
	return min(absolute_max_power,(min_power + (bonus_level + get_current_level())*max_power*0.01)*(1-(min_power/max_power)))


/experience/proc/on_level_up(var/old_level,var/new_level)
	owner.on_level_up(src,old_level,new_level)
	return new_level

/experience/proc/get_max_level()
	return owner.max_level + src.get_prestige_count()*5

/experience/proc/get_prestige_count() //Only used for Skills, currently.
	if(!is_player(owner))
		return 0
	var/mob/living/advanced/player/P = owner
	if(!P.prestige_count[id])
		return 0
	return P.prestige_count[id]
