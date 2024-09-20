/mob/living/proc/get_damage_description(var/mob/examiner)

	if(!health || health.health_max <= 0)
		return null

	var/list/damage_description = list()

	var/tox_mod = health.damage[TOX]/health.health_max
	if(tox_mod > 0.05)
		var/tox_description
		switch(tox_mod)
			if(0.05 to 0.25)
				tox_description = "<i>off color</i>"
			if(0.25 to 0.5)
				tox_description = "sickly"
			if(0.5 to 0.75)
				tox_description = "<b>ill</b>"
			if(0.75 to 1)
				tox_description = "<b>ailing</b>"
			if(1 to INFINITY)
				tox_description = "<u><b>diseased</u></b>"
		damage_description += "<font color='green'>[tox_description]</font>"

	var/rad_mod = health.damage[RAD]/health.health_max
	if(rad_mod > 0.25)
		var/rad_description
		switch(rad_mod)
			if(0.25 to 0.5)
				rad_description = "contaminated"
			if(0.5 to 0.75)
				rad_description = "<b>irradiated</b>"
			if(0.75 to 1)
				rad_description = "<b>ratioactive</b>"
			if(1 to INFINITY)
				rad_description = "<u><b>mutating</u></b>"
		damage_description += "<font color='greenyellow'>[rad_description]</font>"

	if(!length(damage_description))
		return null

	var/prefix = "They look"
	if(examiner == src)
		prefix = "You look"
	else
		switch(gender)
			if(MALE)
				prefix = "He looks"
			if(FEMALE)
				prefix = "She looks"

	var/div_class = "notice"
	switch(health.health_current/health.health_max)
		if(-INFINITY to 0.25)
			div_class = "danger"
		if(0.25 to 0.75)
			div_class = "warning"
		if(0.75 to INFINITY)
			div_class = "notice"

	return div(div_class,"[prefix] [english_list(damage_description)].")


/mob/living/get_examine_list(var/mob/examiner)

	var/object_icon = ICON_TO_HTML(icon,icon_state,32,32)
	. = list(
		div("examine_title","[object_icon][src.name]"),
		div("center bold","Level [level] [initial(src.name)]"),
		div("examine_description_long",src.desc_extended)
	)

	var/activity_text = get_activity_text()
	if(activity_text)
		. += activity_text

	var/damage_description = get_damage_description(examiner)
	if(damage_description)
		. += damage_description

/mob/living/proc/get_activity_text()

	if(dead)
		if(is_player_controlled())
			return div("danger","They are dead, but there may still be some hope.")
		else
			return div("warning","They are dead and lifeless, and their soul has departed...")
	else if(!ai)
		if(ckey_last && !client)
			return div("warning","They seem to be affected by space sleep disorder. They may recover soon.")
		else if(client && client.inactivity >= SECONDS_TO_TICKS(60))
			return div("warning","They seem to be blanking out for [TICKS_TO_SECONDS(client.inactivity)] seconds. They may snap out of it soon.")

	return null

/mob/living/get_examine_details_list(var/mob/examiner)

	. = ..()

	var/pronoun = get_pronoun_he_she_it(src)

	if(ai && ai.use_alerts)
		switch(ai.alert_level)
			if(ALERT_LEVEL_NOISE)
				. += div("warning","[capitalize(pronoun)] seems to be looking for a source of noise.")
			if(ALERT_LEVEL_CAUTION)
				. += div("warning","[capitalize(pronoun)] seems to be looking for someone.")
			if(ALERT_LEVEL_COMBAT)
				if(ai.objective_attack)
					. += div("danger","[capitalize(pronoun)] appears to be in a combative stance, with intent to fight [ai.objective_attack]!")
				else
					. += div("danger","[capitalize(pronoun)] appears to be in a combative stance!")

