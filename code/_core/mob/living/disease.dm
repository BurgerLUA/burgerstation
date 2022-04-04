/mob/living/proc/add_disease(var/disease/disease_to_add)

	if(length(diseases) && diseases[disease_to_add])
		return FALSE

	var/disease/D = new disease_to_add
	D.on_add(src)

	diseases[disease_to_add] = D

	return TRUE

/mob/living/proc/remove_disease(var/disease/disease_to_remove)

	if(!length(diseases) || !diseases[disease_to_remove])
		return FALSE

	var/disease/D = diseases[disease_to_remove]
	D.on_remove(src)

	diseases -= disease_to_remove

	return TRUE