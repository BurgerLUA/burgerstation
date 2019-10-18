mob/living/advanced/get_examine_text(var/mob/examiner)


	var/survival_skill = 1

	if(examiner == src || is_observer(examiner))
		survival_skill = 999

	else if(is_advanced(examiner))
		var/mob/living/advanced/A = examiner
		survival_skill = A.get_skill_level(SKILL_SURVIVAL)


	. = ""

	. += div("examine_title",src.name)
	. += div("examine_description","\"[src.desc]\"")
	. += div("examine_description_long",get_flavortext())

	if(is_player(src) && survival_skill > 10) //I know this is shitcode but whatever
		var/mob/living/advanced/player/P = src
		var/karma_levels = P.mobdata.loaded_data["karma"]
		if(survival_skill > 25)
			. += div("examine_description_long","Karma: [karma_levels]")
		else
			. += div("examine_description_long","Karma: [karma_levels >= 0 ? "In good standing" : "In poor standing"]")

	if(survival_skill > 50)
		. += div("carryweight","Carry Weight: [capacity]/[max_capacity].")

	return .