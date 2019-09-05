/mob/living/advanced/proc/get_flavortext()

	var/strength = get_attribute_level(ATTRIBUTE_STRENGTH)
	var/vitality = get_attribute_level(ATTRIBUTE_VITALITY)
	var/fortitude = get_attribute_level(ATTRIBUTE_FORTITUDE)

	var/intelligence = get_attribute_level(ATTRIBUTE_INTELLIGENCE)
	var/willpower = get_attribute_level(ATTRIBUTE_WILLPOWER)
	var/resolve = get_attribute_level(ATTRIBUTE_RESOLVE)

	var/dexterity = get_attribute_level(ATTRIBUTE_DEXTERITY)
	var/agility = get_attribute_level(ATTRIBUTE_AGILITY)
	var/endurance = get_attribute_level(ATTRIBUTE_ENDURANCE)

	var/karma = get_attribute_level(ATTRIBUTE_KARMA)

	var/weight_muscle = 20 + strength*1.2 + vitality*0.25 - intelligence*0.2
	var/weight_fat = 60 + strength*0.3 - intelligence*0.2 - agility*0.5 - willpower*0.1 - resolve*0.1 - dexterity*0.1 - endurance*0.5
	var/weight_total = weight_fat + weight_muscle
	var/height = 140 + strength*0.1 + agility*0.1 + fortitude*0.2 + vitality*0.05
	var/masculinity = strength*0.75 + endurance*0.25 - intelligence*0.5 - agility*0.25 - dexterity*0.1 + (50 - karma)*0.5   //Negative values are feminine.

	//Sexism and stereotypes ahoy
	if(gender == MALE)
		masculinity += 15
		height += 10
	else
		masculinity -= 25
		weight_fat *= 1.1
		weight_muscle *= 0.9

	if(sex == MALE)
		masculinity += 25
		height += 20
	else
		masculinity -= 45
		weight_fat *= 1.2
		weight_muscle *= 0.8

	var/returning_text = "You see \a "

	switch(height)
		if(-INFINITY to 130)
			returning_text += "extremely short"
		if(130 to 150)
			returning_text += "very short"
		if(150 to 170)
			returning_text += "short"
		if(170 to 180)
			returning_text += "relatively tall"
		if(180 to 190)
			returning_text += "tall"
		if(190 to 200)
			returning_text += "very tall"
		if(200 to INFINITY)
			returning_text += "extremely tall"

	switch(height/weight_total)
		if(-INFINITY to 0.5)
			returning_text += " but "
		if(0.5 to 1.5)
			returning_text += " and "
		if(1.5 to INFINITY)
			returning_text += " but "

	switch(weight_total)
		if(-INFINITY to 40)
			returning_text += "incredibly skinny"
		if(40 to 60)
			returning_text += "skinny"
		if(60 to 80)
			returning_text += "lithe"
		if(80 to 110)
			returning_text += "medium-built"
		if(110 to 130)
			returning_text += "large"
		if(130 to INFINITY)
			returning_text += "wide"

	returning_text += " [mob_species.name]."

	return returning_text

