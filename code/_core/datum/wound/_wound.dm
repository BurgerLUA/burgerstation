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

	var/list/bleed_reference = list("%","% which is lightly bleeding","% which is bleeding","% which is heavily bleeding","% which is hemorrhaging with blood")
	var/list/severity_reference = list("tiny %","small %","medium %","large %","massive %")
	var/list/heal_reference = list("fresh %","recent %","%","old %","% scar")
	var/list/infection_reference = list("clean %","contaminated %","infected %")

	var/atom/weapon //The weapon that caused this.
	var/atom/inflictor //The person using the weapon that caused this.
	var/mob/living/victim //The victim of the wound.
	var/obj/item/organ/location //The location of the wound, if any.

/wound/Destroy()
	weapon = null
	inflictor = null
	victim = null
	location = null
	return ..()

/wound/New(var/mob/living/desired_owner,var/obj/item/organ/desired_location,var/atom/desired_inflictor,var/atom/desired_weapon,var/severity=1)

	. = ..()

	victim = desired_owner
	location = desired_location
	inflictor = desired_inflictor
	weapon = desired_weapon

	severity_level = severity

	if(desired_location && desired_location.health)
		desired_location.health.wounds += src
	else
		qdel(src)
		return FALSE

/wound/proc/get_infection_modifier()
	return clamp( (infection_level_max*0.5 - infection_level)/infection_level_max, -1, 1)

/wound/proc/on_life()

	var/life_tick_mod = LIFE_TICK_SLOW/10 //Convert into seconds.
	var/infection_mod = (infection_level/infection_level_max)

	infection_level += life_tick_mod*(1/600)*(severity_level*0.5)
	heal_level += life_tick_mod*(bleed_level*0.25)*(1/300)*(1 - infection_mod)
	bleed_level += life_tick_mod*(1/300)*(infection_level - heal_level)

	infection_level = clamp(infection_level,0,infection_level_max)
	heal_level = clamp(heal_level,0,heal_level_max)
	bleed_level = clamp(bleed_level,0,bleed_level_max)

/wound/proc/update_name()
	//Format should be "Bleeding Fresh Infected Large Wound"
	name = initial(name)
	name = replacetext(get_heal_name(),"%",name)
	name = replacetext(get_severity_name(),"%",name)
	name = replacetext(get_infection_name(),"%",name)
	name = replacetext(get_bleed_name(),"%",name)

/wound/proc/get_examine_text(var/mob/examiner)
	span("warning","It has \a [src]...")

/wound/proc/get_simple_examine_text(var/mob/examiner)

	var/returning = src.name

	returning = replacetext(get_severity_name(), "%", returning)
	returning = replacetext(get_infection_name(), "%", returning)
	returning = replacetext(get_bleed_name(), "%", returning)
	returning = replacetext(get_heal_name(), "%", returning)

	return returning

/wound/proc/get_severity_name()
	return severity_reference[CEILING(clamp(severity_level,1,length(severity_reference)),1)]

/wound/proc/get_infection_name()
	var/infection_stage = FLOOR(clamp(infection_level,1,length(infection_reference)), 1)
	return infection_reference[infection_stage]

/wound/proc/get_bleed()
	return min(bleed_level,severity_level)

/wound/proc/get_bleed_name()
	return bleed_reference[CEILING(clamp(bleed_level,1,length(bleed_reference)),1)]

/wound/proc/get_heal_name()
	return heal_reference[CEILING(clamp(heal_level,1,length(heal_reference)),1)]

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
			return "It is not bleeding."
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



