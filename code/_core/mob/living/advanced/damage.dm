/mob/living/advanced/get_object_to_damage(var/atom/attacker,var/atom/victim,params)

	var/y_attack = text2num(params["icon-y"])

	if(y_attack >= 24 && src.labeled_organs["head"])
		return src.labeled_organs["head"]

	if(y_attack >= 12)
		if(prob(50) && src.labeled_organs["torso"])
			return src.labeled_organs["torso"]
		else if(prob(50) && src.labeled_organs["l_arm"])
			return src.labeled_organs["l_arm"]
		else if(src.labeled_organs["r_arm"])
			return src.labeled_organs["r_arm"]

	if(y_attack >= 9)
		if(prob(50) && src.labeled_organs["groin"])
			return src.labeled_organs["groin"]
		else if(prob(50) && src.labeled_organs["l_hand"])
			return src.labeled_organs["l_hand"]
		else if(src.labeled_organs["r_hand"])
			return src.labeled_organs["r_hand"]

	if(y_attack >= 4)
		if(prob(50) && src.labeled_organs["l_leg"])
			return src.labeled_organs["l_leg"]
		else if (src.labeled_organs["r_leg"])
			return src.labeled_organs["r_leg"]

	if(prob(50) && src.labeled_organs["l_foot"])
		return src.labeled_organs["l_foot"]
	else if (src.labeled_organs["r_foot"])
		return src.labeled_organs["r_foot"]

	return victim
