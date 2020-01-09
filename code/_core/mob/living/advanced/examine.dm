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

	var/pronoun = capitalize(get_pronoun(src))

	for(var/obj/item/I in worn_objects)
		. += div("notice"," \icon[I] [pronoun] is wearing \the [I.name] on their [I.loc.loc.name].")

	for(var/obj/item/I in held_objects)
		. += div("notice"," \icon[I] [pronoun] is holding \the [I.name] in their [I.loc.loc.name].")

	if(survival_skill > 50)
		. += div("carryweight","Carry Weight: [capacity]/[max_capacity].")

	return .