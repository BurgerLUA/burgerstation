/wound/
	name = "wound"
	id
	desc = "This is a wound."

	var/severity_level = 0 //How large the wound is.
	var/heal_level = 0 //How healed the wound is.
	var/infection_level = 0 //How infected the wound is.
	var/bleed_level = 0 //How much the wound is bleeding.

	var/severity_level_max = 5
	var/heal_level_max = 5
	var/infection_level_max = 3
	var/bleed_level_max = 5

	var/list/bleed_reference = list("%","lightly bleeding %","bleeding %","heavily bleeding %","hemorrhaging %")
	var/list/severity_reference = list("tiny %","small %","medium %","large %","massive %")
	var/list/heal_reference = list("fresh %","recent %","%","old %","% scar")
	var/list/infection_reference = list("clean %","contaminated %","infected %")

	var/atom/weapon //The weapon that caused this.
	var/atom/inflictor //The person using the weapon that caused this.
	var/mob/living/victim //The victim of the wound.
	var/obj/item/organ/location //The location of the wound, if any.

/wound/New(var/mob/living/desired_owner,var/obj/item/organ/desired_location,var/atom/desired_inflictor,var/atom/desired_weapon,var/severity=1)
	..()
	victim = desired_owner
	location = desired_location
	inflictor = desired_inflictor
	weapon = desired_weapon

	severity_level = severity
	bleed_level = severity

/wound/proc/get_infection_modifier()
	return Clamp( (infection_level_max*0.5 - infection_level)/infection_level_max, -1, 1)

#define WOUNDTICK 4	//It takes 4 seconds for on_life() to run

/wound/proc/on_life() //Runs every 4 seconds.
	infection_level += Clamp((severity_level-heal_level)*(WOUNDTICK/600) + infection_level*0.01,0,infection_level_max) //Infection level is increased by 1 per severity level minus it's heal level every 10 minutes and 0.01% of it's current value every 4 seconds.
	bleed_level -= Clamp((WOUNDTICK/300), 0, min(heal_level_max - heal_level,bleed_level_max) ) //Bleed level is decreased by 1 every 5 minutes, or clamped to the inverse of it's heal value
	heal_level += Clamp(bleed_level*(WOUNDTICK/120)*get_infection_modifier(),0,heal_level_max) //Heal level is increased by 1 every 2 minutes unless the wound is infected.

/wound/proc/update_name()
	//Format should be "Bleeding Fresh Infected Large Wound"
	name = initial(name)
	name = replacetext(get_severity_name(),"%",name)
	name = replacetext(get_infection_name(),"%",name)
	name = replacetext(get_heal_name(),"%",name)
	name = replacetext(get_bleed_name(),"%",name)

/wound/proc/get_examine_text(var/mob/examiner)
	span("warning","It has \a [src]...")

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
	return (1+severity_level)*(1+(infection_level/infection_level_max))*(1+(bleed_level/bleed_level_max))

/wound/proc/get_max_pain()
	return (1+severity_level_max)*(1+infection_level_max)*(1+bleed_level_max)

/wound/proc/get_heal_time()
	return min(heal_level,severity_level)*(infection_level)

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
			return span("danger","It will be the death of me if I do not treat this right now!")

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
	desc = ""

/wound/laceration/
	name = "laceration"
	id = "laceration"
	desc = ""

/wound/abration/
	name = "abration"
	id = "abration"
	desc = ""

/wound/pucture/
	name = "pucture wound"
	id = "pucture"
	desc = ""

/wound/penetration/
	name = "penetration wound"
	id = "penetration"
	desc = ""

/wound/gun_shot/
	name = "gunshot wound"
	id = "gunshot"
	desc = ""
