mob/living/advanced/get_examine_text(var/mob/examiner)

	. = ..()

	if(examiner == src)
		. += div("carryweight","Carry Weight: [capacity]/[max_capacity].")

	. += get_flavortext()

	return .