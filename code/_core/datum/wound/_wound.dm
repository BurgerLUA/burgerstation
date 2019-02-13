/wound/
	var/name = "wound"
	var/id
	var/description = "This is a wound."

	var/severity_level = 0
	var/heal_level = 0
	var/infection_level = 0
	var/bleed_level = 0

	var/list/bleed_reference = list("%","lightly bleeding %","bleeding %","heavily bleeding %","hemorrhaging %")
	var/list/severity_reference = list("tiny %","small %","medium %","large %","massive %")
	var/list/heal_reference = list("fresh %","recent %","%","old %","% scar")
	var/list/infection_reference = list("clean %","contaminated %","infected %","colonized %")

	var/atom/weapon //The weapon that caused this.
	var/atom/inflictor //The person using the weapon that caused this.
	var/atom/victim //The victim of the wound.

/wound/proc/apply()

/wound/proc/remove()

/wound/proc/update()
	//Should be "Bleeding Fresh Infected Large Wound"
	name = initial(name)
	name = replacetext(get_severity_name(),"%",name)
	name = replacetext(get_infection_name(),"%",name)
	name = replacetext(get_heal_name(),"%",name)
	name = replacetext(get_bleed_name(),"%",name)

/wound/proc/examine(var/atom/examiner)
	examiner.to_chat("It has \a [src]...")

/wound/proc/on_life()
	//Apply the wound

/wound/proc/get_severity_name()
	return severity_reference[ceiling(Clamp(severity_level,1,length(severity_reference)))]

/wound/proc/get_infection_name()
	return infection_reference[ceiling(Clamp(infection_level+1,1,length(infection_reference)))]

/wound/proc/get_bleed()
	return min(bleed_level,severity_level)

/wound/proc/get_bleed_name()
	return bleed_reference[ceiling(Clamp(bleed_level + 1,1,length(bleed_reference)))]

/wound/proc/get_heal_name()
	return heal_reference[ceiling(Clamp(heal_level,1,length(heal_reference)))]

/wound/proc/get_pain()
	return (1+severity_level)*(1+infection_level)*(1+bleed_level)

/wound/proc/get_heal_time()
	return min(heal_level,severity_level)*(infection_level)

/wound/proc/get_pain_text()
	switch(get_pain())
		if(0)
			return ""
		if(0 to 2)
			return span("notice","It tingles.")
		if(2 to 4)
			return span("warning","It hurts quite a bit.")
		if(4 to 6)
			return span("warning","It really hurts!")
		if(6 to 8)
			return span("danger","It is very painful!")
		if(10 to 100)
			return span("danger","It hurts like hell!")

/wound/proc/get_heal_time_text()
	switch(get_heal_time())
		if(0)
			return span("notice","The wound is healed.")
		if(0 to 2)
			return span("notice","It looks like it will heal on its own.")
		if(2 to 4)
			return span("notice","I should find some medicine to treat this.")
		if(4 to 6)
			return span("warning","I really need medicine to treat this.")
		if(6 to 8)
			return span("danger","I really need professional medical attention to treat this, and fast!")
		if(8 to 100)
			return span("danger","It will be the of me if I do not treat this right now!")

/wound/proc/get_bleed_text()
	switch(get_bleed())
		if(0)
			return ""
		if(0 to 1)
			return span("notice","A little blood trickling out.")
		if(1 to 2)
			return span("warning","It is bleeding.")
		if(2 to 3)
			return span("warning","It is bleeding pretty badly.")
		if(3 to 4)
			return span("danger","It is bleeding profusely!")
		if(4 to 5)
			return span("danger","It is gushing blood!")


/wound/incision/
	name = "incision"
	id = "incision"
	description = ""

/wound/incision/examine(var/atom/examiner)






/wound/laceration/
	name = "laceration"
	id = "laceration"
	description = ""

/wound/abration/
	name = "abration"
	id = "abration"
	description = ""

/wound/pucture/
	name = "pucture wound"
	id = "pucture"
	description = ""

/wound/penetration/
	name = "penetration wound"
	id = "penetration"
	description = ""

/wound/penetration/
	name = "gunshot wound"
	id = "gunshot"
	description = ""
