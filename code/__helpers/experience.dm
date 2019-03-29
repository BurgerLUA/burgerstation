/proc/calculate_class(var/mob/living/owner,var/list/skills_and_attributes)

	var/list/experience/total_list = owner.skills + owner.attributes

	var/list/starting_list = list(
		"Security Officer" = 0,
		"Warden"= 0,
		"Detective"= 0,
		"Engineer"= 0,
		"Atmospheric Technician"= 0,
		"Scientist"= 0,
		"Roboticist"= 0,
		"Medical Doctor"= 0,
		"Chemist"= 0,
		"Geneticist"= 0,
		"Virologist"= 0,
		"Janitor"= 0,
		"Bartender"= 0,
		"Cook"= 0,
		"Botanist"= 0,
		"Clown"= 0,
		"Mime"= 0,
		"Chaplain"= 0,
		"Curator"= 0,
		"Quartermaster"=0,
		"Cargo Technician"= 0,
		"Shaft Miner"= 0,
		"Assistant"= 0,
		"Lawyer"= 0
	)

	for(var/id in total_list)
		var/experience/E = total_list[id]
		for(var/tag in starting_list)
			starting_list[tag] += skills_and_attributes[id]*E.associated_classes[tag]

	for(var/tag in starting_list)
		owner << "[tag]: [starting_list[tag]]"



	return get_best_key(starting_list)