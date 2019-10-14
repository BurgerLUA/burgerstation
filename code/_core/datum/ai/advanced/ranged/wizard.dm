/ai/advanced/ranged/wizard

	attack_delay = 10

	var/turf/list/teleport_locations = list()

	left_click_chance = 70

/ai/advanced/ranged/wizard/New(var/mob/living/desired_owner)
	. = ..()

	for(var/obj/marker/boss/wizard/W in world)
		teleport_locations += get_turf(W)

	return .

/ai/advanced/ranged/wizard/handle_attacking()

	. = ..()

	if(objective_attack && attack_ticks == 0)
		var/turf/desired_location = pick(teleport_locations)
		new /obj/effect/temp/phase/out(get_turf(owner))
		owner.force_move(desired_location)
		new /obj/effect/temp/phase(desired_location)


	return .


/ai/advanced/ranged/wizard/hostile_message()
	owner.say("Ohohoho! Someone challenges me?")